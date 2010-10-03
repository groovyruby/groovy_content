class CreateInquiryForms < ActiveRecord::Migration
  def self.up
    create_table :inquiry_forms do |t|
      t.string :name
      t.string :slug
      t.references :site
      t.timestamps
    end
  end

  def self.down
    drop_table :inquiry_forms
  end
end
