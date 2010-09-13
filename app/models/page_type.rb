class PageType < ActiveRecord::Base

  belongs_to :site

  validates :name, :presence=>true, :uniqueness=>{:scope=>:site_id}
  validates :slug, :presence=>true, :uniqueness=>{:scope=>:site_id}
  validates :site_id, :presence=>true

  before_validation :fill_in_slug

  def fill_in_slug
    self.slug = self.name.parameterize if self.slug.blank? and not self.name.blank?
  end

end
