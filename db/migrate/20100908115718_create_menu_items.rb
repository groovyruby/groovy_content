class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string :name
      t.references :linkable, :polymorphic=>true
      t.string :url
      t.string :target, :default=>"_self"
      t.string :title
      t.boolean :is_landing, :default=>false
      t.integer :position, :default=>0
      t.references :site
      t.timestamps
    end
  end

  def self.down
    drop_table :menu_items
  end
end
