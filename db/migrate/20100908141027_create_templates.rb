class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.string :name
      t.text :content
      t.boolean :is_deletable, :default=>true
      t.references :site
      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
