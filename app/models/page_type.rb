class PageType < ActiveRecord::Base

  belongs_to :site

  has_many :property_types, :dependent=>:destroy
#  has_many :properties
  has_many :pages


  validates :name, :presence=>true, :uniqueness=>{:scope=>:site_id}
  validates :slug, :presence=>true, :uniqueness=>{:scope=>:site_id}
  validates :site_id, :presence=>true

  validates_associated :property_types

  accepts_nested_attributes_for :property_types, :allow_destroy=>true, :reject_if=>proc{ |f| f['name'].blank? }

  attr_accessible :name, :slug, :property_types_attributes, :show_content

  before_validation :fill_in_slug

  def fill_in_slug
    self.slug = self.name.parameterize if self.slug.blank? and not self.name.blank?
  end

end
