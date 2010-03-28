class CreateToolbawksProfiles < ActiveRecord::Migration
  def self.up
    create_table :toolbawks_profiles do |t|
      t.column :name, :string
      t.column :toolbawks_user_id, :integer
      t.column :is_default, :boolean
    end
  end

  def self.down
    drop_table :toolbawks_profiles
  end
end