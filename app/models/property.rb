class Property < ActiveRecord::Base
  belongs_to :page
  #belongs_to :page_type
  belongs_to :property_type

end
