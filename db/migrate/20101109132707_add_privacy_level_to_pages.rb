class AddPrivacyLevelToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :privacy_level, :integer, :default=>Page::PRIVACY_LEVELS[:public]
  end

  def self.down
    remove_column :pages, :privacy_level
  end
end
