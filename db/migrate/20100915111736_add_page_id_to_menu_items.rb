class AddPageIdToMenuItems < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :page_id, :integer
    remove_column :menu_items, :linkable_type
    remove_column :menu_items, :linkable_id
  end

  def self.down
    remove_column :menu_items, :page_id
    change_table :menu_items do |t|
      t.references :linkable, :polymorphic=>true
    end
  end
end
