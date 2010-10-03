class CreateInquiryFields < ActiveRecord::Migration
  def self.up
    create_table :inquiry_fields do |t|
      t.string :name
      t.string :identifier
      t.string :field_type
      t.string :field_options
      t.boolean :is_required
      t.references :inquiry_form
      t.timestamps
    end
  end

  def self.down
    drop_table :inquiry_fields
  end
end
