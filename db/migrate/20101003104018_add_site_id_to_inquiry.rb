class AddSiteIdToInquiry < ActiveRecord::Migration
  def self.up
    add_column :inquiries, :site_id, :integer
  end

  def self.down
    remove_column :inquiries, :site_id
  end
end
