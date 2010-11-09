class Site < ActiveRecord::Base
  attr_accessor :clone_from
  scope :default, where('is_default=?', true)

  has_many :inquiries
  has_many :inquiry_forms, :dependent=>:destroy
  has_many :page_types, :dependent=>:destroy
  has_many :pages, :dependent => :destroy
  has_many :menu_items, :dependent=>:destroy
  has_many :templates, :dependent=>:destroy

  validates :title, :presence=>true, :uniqueness=>true
  validates :domain, :presence=>true, :uniqueness=>true, :format=>{:with=>/^[a-z0-9]+[a-z0-9\.\_\-]*\.[a-z]{2,5}$/i}


  attr_accessible :title, :domain, :is_default, :clone_from

  before_save :lowercase_domain
  before_save :mark_as_default
  after_save :take_care_of_default_site
  after_create :create_or_clone_required_records


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

  def create_or_clone_required_records
    s = nil
    s = Site.where('id=?', self.clone_from).first unless self.clone_from.blank?
    if s.blank?
      t1 = self.templates.new({:name=>'layout', :content=>"Layout <br /> :D\n{% block content %}\n{% endblock %}\n"})
      t1.save
      t2 = self.templates.new({:name=>'page', :content=>"{% extends layout %}\n{% block content %}\n{{page.title}}\n{% endblock %}\n"})
      t2.save
      t3 = self.templates.new({:name=>'head'})
      t3.save
      p1 = self.pages.new({:title=>'Home page'})
      p1.save
      mi1 = self.menu_items.new({:name=>'home page'})
      mi1.page = p1
      mi1.save
    else
      for t in s.templates.all
        temp = t.clone
        temp.site = self
        temp.save
      end
      for pt in s.page_types.all
        page_type = pt.clone
        page_type.site = self
        page_type.save
        for prt in pt.property_types.all
          property_type = prt.clone
          property_type.page_type = page_type
          property_type.properties = []
          property_type.save
        end
      end
      for p in s.pages.all
        page = p.clone
        page.site = self
        page.parent = self.pages.where('slug=?', p.parent.slug).first unless p.parent.blank?
        page.page_type = self.page_types.where('slug=?', p.page_type.slug).first unless p.page_type.blank?
        page.save
        for property_type in page.page_type.property_types
          property = property_type.properties.new(:property_type_id=>property_type.id)
          property.page_type = page.page_type
          page.properties << property
          property.save
        end unless p.page_type.blank?
      end
      for m in s.menu_items.all
        menu = m.clone
        menu.page = self.pages.where('slug=?', m.page.slug).first unless menu.page.blank?
        menu.site = self
        menu.save
      end
      for inf in s.inquiry_forms.all
        inquiry = inf.clone
        inquiry.site = self
        inquiry.save
        for infi in inf.inquiry_fields.all
          inquiry_field = infi.clone
          inquiry_field.inquiry_form = inquiry
          inquiry_field.save
        end
      end
    end

  end
end
