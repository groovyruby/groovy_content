class AddPropertyTypeIdToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :property_type_id, :integer
  end

  def self.down
    remove_column :properties, :property_type_id
  end
end
