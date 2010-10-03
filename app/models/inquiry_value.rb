class InquiryValue < ActiveRecord::Base
  belongs_to :inquiry
  belongs_to :inquiry_field
  belongs_to :inquiry_form
  
  attr_accessible :field_value, :inquiry_field_id, :inquiry_form_id
end
