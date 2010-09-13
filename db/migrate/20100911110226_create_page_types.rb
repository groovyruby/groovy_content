class CreatePageTypes < ActiveRecord::Migration
  def self.up
    create_table :page_types do |t|
      t.string :name
      t.string :slug
      t.references :site
      t.timestamps
    end
  end

  def self.down
    drop_table :page_types
  end
end
