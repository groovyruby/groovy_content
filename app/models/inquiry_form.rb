class InquiryForm < ActiveRecord::Base
  
  belongs_to :site
  has_many :inquiries, :dependent=>:destroy
  has_many :inquiry_fields, :dependent=>:destroy
  
  validates_associated :inquiry_fields

  accepts_nested_attributes_for :inquiry_fields, :allow_destroy=>true, :reject_if=>proc{ |f| f['name'].blank? }
  
  attr_accessible :name, :slug, :inquiry_fields_attributes
  
end
