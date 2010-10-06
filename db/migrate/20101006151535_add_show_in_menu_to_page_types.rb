class AddShowInMenuToPageTypes < ActiveRecord::Migration
  def self.up
    add_column :page_types, :show_in_menu, :boolean, :default=>true
  end

  def self.down
    remove_column :page_types, :show_in_menu
  end
end
