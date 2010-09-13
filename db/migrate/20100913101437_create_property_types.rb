class CreatePropertyTypes < ActiveRecord::Migration
  def self.up
    create_table :property_types do |t|
      t.string :name
      t.string :identifier
      t.string :field_type
      t.integer :position, :default=>0
      t.references :page_type
      t.timestamps
    end
  end

  def self.down
    drop_table :property_types
  end
end
