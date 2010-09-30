class Page < ActiveRecord::Base

  scope :of_type, lambda { |page_type| where("page_type_id = ?", page_type.id) }
  scope :without_type, where('page_type_id is null')

  belongs_to :page_type
  belongs_to :parent, :class_name => "Page", :foreign_key => "parent_id"
  belongs_to :site
  belongs_to :template
  
  has_many :menu_items, :as=>:linkable
  has_many :properties
  has_many :sub_pages, :class_name => "Page", :foreign_key => "parent_id"

  validates :title, :presence=>true
  validates :slug, :presence=>true, :format=>{:with=>/^[a-z0-9\_\-]+$/}, :uniqueness=>{:scope=>:site_id}
  validates :site_id, :presence=>true, :numericality=>true
  validates :parent_id, :numericality=>true, :if=>:parent_id?


  accepts_nested_attributes_for :properties, :allow_destroy=>true
  attr_accessible :title, :slug, :content, :properties_attributes, :parent_id, :template_id


  before_validation :fill_in_slug

  def to_s
    self.slug
  end
  
  def to_param
    "#{self.id}-#{self.slug}"
  end

  def fill_in_slug
    if self.slug.blank? and not self.title.blank?
      self.slug = "#{self.page_type.slug}-" unless self.page_type.blank?
      self.slug = self.title.parameterize
    end
  end

  def to_liquid
    liquid = { "title"  => self.title,
      "content" => self.content,
      'to_param' => self.to_param,
      'sub_pages' => self.sub_pages.all,
      'siblings'  => self.parent.blank? ? [] : self.parent.sub_pages.all,
      'slug' => self.slug
    }
    # TODO: for now this is enough.
    self.properties.each do |p|
      liquid[p.property_type.identifier] = p.property_value
    end unless self.properties.blank?
    liquid
  end
  


end
