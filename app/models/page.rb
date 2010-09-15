class Page < ActiveRecord::Base

  belongs_to :page_type
  belongs_to :site
  has_many :menu_items, :as=>:linkable
  has_many :properties

  validates :title, :presence=>true
  validates :slug, :presence=>true, :format=>{:with=>/^[a-z0-9\_\-]+$/}, :uniqueness=>{:scope=>:site_id}
  validates :site_id, :presence=>true


  accepts_nested_attributes_for :properties, :allow_destroy=>true
  attr_accessible :title, :slug, :content, :properties_attributes


  before_validation :fill_in_slug

  def fill_in_slug
    if self.slug.blank? and not self.title.blank?
      self.slug = "#{self.page_type.slug}-" unless self.page_type.blank?
      self.slug = self.title.parameterize
    end
  end

  def to_liquid
    liquid = { "title"  => self.title,
      "content" => self.content }
    # TODO: for now this is enough.
    self.properties.each do |p|
      liquid[p.property_type.identifier] = p.property_value
    end unless self.properties.blank?
    liquid
  end


end
