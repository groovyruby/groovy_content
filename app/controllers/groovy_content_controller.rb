class GroovyContentController < ApplicationController

  # TODO: for now we'll use db based templates
  #before_filter :prepend_view_path_for_site
  before_filter :fetch_menu
  before_filter :fetch_templates
  before_filter :fetch_pages


  helper_method :current_site




  def current_site
    s = Site.find_by_domain(request.host)
    s = Site.default.first unless s
    s
  end

  protected
    def fetch_menu
      @menu_items = current_site ? current_site.menu_items.visible.by_position.all : []
    end

    def fetch_templates
      @layout_template = current_site.templates.where('name=?', 'layout').first
      @page_template = current_site.templates.where('name=?', 'page').first
    end

    def fetch_pages
      @collections = {'pages'=> current_site.pages.without_type.all}
      for pt in current_site.page_types.all
        @collections[pt.slug] = current_site.pages.of_type(pt).all
      end
    end

    def prepend_view_path_for_site
      # todo performance issue here - templates are cached on each request. lame.
      s = current_site
      self.prepend_view_path(File.join(::Rails.root.to_s, 'app', 'views', s.domain)) unless s.blank?

    end

end
