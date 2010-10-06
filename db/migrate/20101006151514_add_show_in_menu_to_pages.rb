class AddShowInMenuToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :show_in_menu, :boolean, :default=>true
  end

  def self.down
    remove_column :pages, :show_in_menu
  end
end
