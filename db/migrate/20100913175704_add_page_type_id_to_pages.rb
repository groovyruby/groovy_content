class AddPageTypeIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_type_id, :integer
  end

  def self.down
    remove_column :pages, :page_type_id
  end
end
