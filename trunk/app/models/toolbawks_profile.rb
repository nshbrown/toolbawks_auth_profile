class ToolbawksProfile < ActiveRecord::Base
  belongs_to :user, :class_name => 'ToolbawksUser', :foreign_key => 'toolbawks_user_id'
  has_many :addresses, :class_name => 'ToolbawksAddress', :dependent => :destroy, :foreign_key => 'toolbawks_profile_id'
  has_one :default_address, :class_name => 'ToolbawksAddress', :foreign_key => 'toolbawks_profile_id', :conditions => ['is_default = ?', true]
  
  validates_length_of :name, :minimum => 2, :message => 'Name is too short'
end