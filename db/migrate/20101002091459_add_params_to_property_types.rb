class AddParamsToPropertyTypes < ActiveRecord::Migration
  def self.up
    add_column :property_types, :params, :string
  end

  def self.down
    remove_column :property_types, :params
  end
end
