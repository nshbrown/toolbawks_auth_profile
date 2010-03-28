class CreateToolbawksAddresses < ActiveRecord::Migration
  def self.up
    create_table :toolbawks_addresses do |t|
      t.column :name, :string
      t.column :company, :string
      t.column :address_line_one, :string
      t.column :address_line_two, :string
      t.column :city, :string
      t.column :country, :string
      t.column :state_province, :string
      t.column :zip_postal_code, :string, :length => 10
      t.column :phone, :string
      t.column :is_default, :boolean
      t.column :toolbawks_profile_id, :integer
    end
  end

  def self.down
    drop_table :toolbawks_addresses
  end
end