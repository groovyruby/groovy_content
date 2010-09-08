class Page < ActiveRecord::Base

  belongs_to :site
  has_many :menu_items, :as=>:linkable

  validates :title, :presence=>true
  validates :slug, :presence=>true, :format=>{:with=>/^[a-z0-9\_\-]+$/}
  validates :site_id, :presence=>true

  attr_accessible :title, :slug, :content

  before_validation :fill_in_slug

  def fill_in_slug
    self.slug = self.title.parameterize if self.slug.blank? and not self.title.blank?
  end

  def to_liquid
    { "title"  => self.title,
      "content" => self.content }
  end


end
