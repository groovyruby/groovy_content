class AddShowOnListsToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :show_on_lists, :boolean, :default=>true
  end

  def self.down
    remove_column :pages, :show_on_lists
  end
end
