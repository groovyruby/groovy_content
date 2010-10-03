class InquiryField < ActiveRecord::Base
  
  FIELD_TYPES = %w{ string text email select boolean }
  
  belongs_to :inquiry_form
  
  validates :name, :presence=>true
  validates :identifier, :presence=>true, :uniqueness=>{:scope=>:inquiry_form_id}
  
  attr_accessible :name, :identifier, :field_type, :field_options, :is_required
  
end
