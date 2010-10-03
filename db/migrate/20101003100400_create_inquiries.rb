class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table :inquiries do |t|
      t.references :inquiry_form

      t.timestamps
    end
  end

  def self.down
    drop_table :inquiries
  end
end
