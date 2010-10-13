class AddEmailsToSettings < ActiveRecord::Migration
  def self.up
    s = Setting.new
    s.label = 'Email'
    s.identifier = 'email'
    s.field_type = 'string'
    s.value = 'admin@groovyru.by'
    s.scope = 'general_settings'
    s.save!
    
    s = Setting.new
    s.label = 'Default "from" email address'
    s.identifier = 'default_from_email'
    s.field_type = 'string'
    s.value = 'inquiries@groovyru.by'
    s.scope = 'general_settings'
    s.save!
    
  end

  def self.down
  end
end
