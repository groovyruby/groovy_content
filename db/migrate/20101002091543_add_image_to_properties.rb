class AddImageToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :image_file_name, :string
    add_column :properties, :image_file_size, :integer
    add_column :properties, :image_content_type, :string
  end

  def self.down
    remove_column :properties, :image_content_type
    remove_column :properties, :image_file_size
    remove_column :properties, :image_file_name
  end
end
