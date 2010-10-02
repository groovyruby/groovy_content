class PropertyType < ActiveRecord::Base

  FIELD_TYPES = %w( text boolean file image string )

  belongs_to :page_type
  has_many :properties, :dependent=>:destroy

  validates :name, :presence=>true
  validates :identifier, :presence=>true
  validates :field_type, :presence=>true, :inclusion=>{:in=>PropertyType::FIELD_TYPES}
  
  attr_accessible :name, :identifier, :field_type, :params

  before_validation :fill_in_identifier

  def fill_in_identifier
    self.identifier = self.name.parameterize if self.identifier.blank? and not self.name.blank?
  end

end
