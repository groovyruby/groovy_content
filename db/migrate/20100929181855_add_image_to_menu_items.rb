class AddImageToMenuItems < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :image_file_name, :string
    add_column :menu_items, :image_content_type, :string
    add_column :menu_items, :image_file_size, :integer
    add_column :menu_items, :image_updates_at, :datetime
  end

  def self.down
    remove_column :menu_items, :image_updates_at
    remove_column :menu_items, :image_file_size
    remove_column :menu_items, :image_content_type
    remove_column :menu_items, :image_file_name
  end
end
