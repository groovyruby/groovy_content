class AddIsVisibleToMenuItems < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :is_visible, :boolean, :default=>true
  end

  def self.down
    remove_column :menu_items, :is_visible
  end
end
