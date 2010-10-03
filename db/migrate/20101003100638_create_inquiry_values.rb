class CreateInquiryValues < ActiveRecord::Migration
  def self.up
    create_table :inquiry_values do |t|
      t.references :inquiry
      t.text :field_value
      t.references :inquiry_field
      t.references :inquiry_form

      t.timestamps
    end
  end

  def self.down
    drop_table :inquiry_values
  end
end
