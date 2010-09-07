class AddIsDefaultToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :is_default, :boolean, :default=>false
  end

  def self.down
    remove_column :sites, :is_default
  end
end
