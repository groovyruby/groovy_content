class Page < ActiveRecord::Base

  belongs_to :site

  validates :title, :presence=>true
  validates :slug, :presence=>true, :format=>{:with=>/^[a-z0-9\_]+$/}
  validates :site_id, :presence=>true

  attr_accessible :title, :slug, :content


end
