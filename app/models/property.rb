class Property < ActiveRecord::Base
  belongs_to :page
  belongs_to :page_type
  belongs_to :property_type
  
  
  has_attached_file :attachment
  has_attached_file :image, :styles => { :limited => "800x600>", :custom=>Proc.new{ |p| PropertyType.find(p.property_type_id).params }, :thumb => "100x100>" }
  
  attr_accessible :property_value, :page_id, :page_type_id, :property_type_id, :property_value, :image, :attachment

end
