# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

unless User.find_by_email('admin@example.com')
  user = User.new({:email=>"admin@example.com", :password=>"q1w2e3", :password_confirmation=>"q1w2e3"})
  user.save
  user.confirm!
end

unless Setting.find_by_identifier('instance_name')
  s = Setting.new
  s.identifier = 'instance_name'
  s.value = 'GroovyContent'
  s.field_type = 'string'
  s.label = 'Instance name'
  s.save
end