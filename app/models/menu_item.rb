class MenuItem < ActiveRecord::Base
  TARGETS = %w{ _self _blank _top _parent }

  scope :by_position, order('position ASC')
  scope :visible, where('is_visible=?', true)
  
  belongs_to :site
  belongs_to :page

  validates :name, :presence=>true
  validates :position, :numericality=>true
  validates :target, :inclusion=>{ :in=>MenuItem::TARGETS }
  validates :site_id, :presence=>true

  has_attached_file :image, :styles => { :menu => Setting.get(:menu_item_image_size), :thumb => "100x100>" }

  attr_accessible :name, :title, :target, :url, :is_landing, :position, :page_id, :image, :is_visible

  before_save :mark_as_landing
  after_save :take_care_of_landing_item

  def take_care_of_landing_item
    if self.is_landing?
      MenuItem.update_all(['is_landing=? ', false], ['id!=? and site_id=?', self.id, self.site_id])
    end
  end

  def mark_as_landing
    if MenuItem.where('is_landing=? and site_id=?', true, self.site_id).all.count == 0
      self.is_landing = true
    end
  end

  def to_liquid
    { "name"  => self.name,
      "page" => self.page,
      "page_id" => self.page_id,
      "url" => self.url,
      "target" => self.target,
      "image"=> self.image_file_name.blank? ? '' : self.image.url(:menu)

    }
  end

end
