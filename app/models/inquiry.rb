class Inquiry < ActiveRecord::Base
  belongs_to :inquiry_form
  belongs_to :site
  
  has_many :inquiry_values, :dependent=>:destroy
  
  accepts_nested_attributes_for :inquiry_values, :allow_destroy=>true
  
  attr_accessible :inquiry_form_id, :inquiry_values_attributes
end
