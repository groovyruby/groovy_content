class Site < ActiveRecord::Base

  scope :default, where('is_default=?', true)

  has_many :pages, :dependent => :destroy
  has_many :menu_items
  has_many :templates

  validates :title, :presence=>true, :uniqueness=>true
  validates :domain, :presence=>true, :uniqueness=>true, :format=>{:with=>/^[a-z0-9]+[a-z0-9\.\_\-]*\.[a-z]{2,5}$/i}


  attr_accessible :title, :domain, :is_default

  before_save :lowercase_domain
  before_save :mark_as_default
  after_save :take_care_of_default_site
  after_create :create_templates


  def lowercase_domain
    self.domain = self.domain.downcase
  end

  def take_care_of_default_site
    if self.is_default?
      Site.update_all(['is_default=?', false], ['id!=?', self.id])
    end
  end

  def mark_as_default
    if Site.where('is_default=?', true).all.count == 0
      self.is_default = true
    end
  end

  def to_s
    self.title
  end

  def create_templates
    t1 = self.templates.new({:name=>'layout'})
    t1.save
    t2 = self.templates.new({:name=>'page'})
    t2.save


  end
end
