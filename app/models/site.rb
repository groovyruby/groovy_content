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
  after_create :create_required_records


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

  def create_required_records
    t1 = self.templates.new({:name=>'layout', :content=>"Layout <br /> :D\n{% block content %}\n{% endblock %}\n"})
    t1.save
    t2 = self.templates.new({:name=>'page', :content=>"{% extends layout %}\n{% block content %}\n{{page.title}}\n{% endblock %}\n"})
    t2.save
    t3 = self.templates.new({:name=>'head'})
    t3.save
    p1 = self.pages.new({:title=>'Home page'})
    p1.save
    mi1 = self.menu_items.new({:name=>'home page'})
    mi1.linkable = p1
    mi1.save

  end
end
