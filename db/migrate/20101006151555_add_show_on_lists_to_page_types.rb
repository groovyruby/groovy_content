class AddShowOnListsToPageTypes < ActiveRecord::Migration
  def self.up
    add_column :page_types, :show_on_lists, :boolean, :default=>true
  end

  def self.down
    remove_column :page_types, :show_on_lists
  end
end
