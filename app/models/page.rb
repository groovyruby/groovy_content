class Page < ActiveRecord::Base
  PRIVACY_LEVELS = {:public=>0, :protected=>1, :private=>2}
  
  
  scope :of_type, lambda { |page_type| where("page_type_id = ?", page_type.id) }
  scope :without_type, where('page_type_id is null')
  scope :shown_on_lists, where('show_on_lists = ?', true)
  scope :displayable_in_menu, where('show_in_menu = ?', true)
  scope :by_position, order('position ASC')
  scope :public, where('privacy_level=?', Page::PRIVACY_LEVELS[:public])
  scope :roots, where('parent_id is null')

  belongs_to :page_type
  belongs_to :parent, :class_name => "Page", :foreign_key => "parent_id"
  belongs_to :site
  belongs_to :template
  
  has_many :menu_items, :as=>:linkable
  has_many :properties, :dependent=>:destroy
  has_many :sub_pages, :class_name => "Page", :foreign_key => "parent_id"

  validates :title, :presence=>true
  validates :slug, :presence=>true, :format=>{:with=>/^[a-z0-9\_\-]+$/}, :uniqueness=>{:scope=>:site_id}
  validates :site_id, :presence=>true, :numericality=>true
  validates :parent_id, :numericality=>true, :if=>:parent_id?


  accepts_nested_attributes_for :properties, :allow_destroy=>true
  attr_accessible :title, :slug, :content, :properties_attributes, :parent_id, :template_id, :page_type_id, :show_in_menu, :show_on_lists, :privacy_level


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
      'displayable_sub_pages' => self.sub_pages.displayable_in_menu.all,
      'siblings'  => self.parent.blank? ? [] : self.parent.sub_pages.all,
      'displayable_siblings' => self.parent.blank? ? [] : self.parent.sub_pages.displayable_in_menu.all,
      'public_displayable_sub_pages' => self.sub_pages.displayable_in_menu.public.all,
      'public_displayable_siblings' =>  self.parent.blank? ? [] : self.parent.sub_pages.public.displayable_in_menu.all,
      'slug' => self.slug,
      'parent' => self.parent
    }
    # TODO: for now this is enough.
    self.properties.each do |p|
      case p.property_type.field_type
        when 'file'
          liquid[p.property_type.identifier] = p.attachment_file_name.blank? ? "" : p.attachment.url 
        when 'image'
          liquid[p.property_type.identifier+"_original"] = p.image.url
          liquid[p.property_type.identifier+"_limited"] = p.image.url(:limited)
          liquid[p.property_type.identifier+"_custom"] = p.image.url(:custom)
          liquid[p.property_type.identifier+"_thumb"] = p.image.url(:thumb)
        else
          liquid[p.property_type.identifier] = p.property_value
      end
      
    end unless self.properties.blank?
    liquid
  end


end
