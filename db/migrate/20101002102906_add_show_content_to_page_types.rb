class AddShowContentToPageTypes < ActiveRecord::Migration
  def self.up
    add_column :page_types, :show_content, :boolean, :default=>true
  end

  def self.down
    remove_column :page_types, :show_content
  end
end
