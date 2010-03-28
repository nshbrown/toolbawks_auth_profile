class ToolbawksAddress < ActiveRecord::Base
  belongs_to :profile, :class_name => 'ToolbawksProfile', :foreign_key => 'toolbawks_profile_id'

  validates_length_of :name, :minimum => 3, :message => 'Name is too short'
  validates_length_of :address_line_one, :minimum => 5, :message => 'Address is too short'

  validates_format_of :zip_postal_code, :with => /((^([a-z]\d[a-z])\s?(\d[a-z]\d)$)|(^([0-9]{5})(-?\d{4})?$))/ims, :message => 'Code is invalid'
  
  validates_presence_of :city, :message => 'City is required'
  validates_presence_of :state_province, :message => 'State / Province is required'
  validates_presence_of :country, :message => 'Country is required'
  
  def country_state_province=(value)
    country_and_state_province = ToolbawksAddress.determine_country_and_state_province?(value)
    
    self.country = country_and_state_province[:country]
    self.state_province = country_and_state_province[:state_province]
  end
  
  def self.determine_country_and_state_province?(value)
    ToolbawksAuthProfile.priority_countries.each do |country_group|
      # International is the only list of countries
      country = (country_group[:label] != 'International') ? country_group[:label] : false
      
      country_group[:children].each do |country_or_state_province|
        if value == country_or_state_province
          if country
            # It is a state / province
            return {
              :state_province => country_or_state_province,
              :country => country
            }
          else
            # It is a country
            return {
              :state_province => nil,
              :country => country_or_state_province
            }
          end
        end
      end
    end

    return {
      :state_province => nil,
      :country => 'Unknown'
    }
  end
  
  def country_state_province
    return self.state_province ? self.state_province : self.country
  end
  
  def toolbawks_address_id=(val)
    nil
  end
  
  def toolbawks_address_id
    nil
  end
end