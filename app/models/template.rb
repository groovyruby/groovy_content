class Template < ActiveRecord::Base

  belongs_to :site
  has_many :pages, :dependent=>:nullify
  
  validates :name, :presence=>true, :uniqueness=>{:scope=>:site_id}
  validates :site_id, :presence=>true, :numericality=>true

  attr_accessible :name, :content

end
