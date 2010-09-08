class GroovyContentController < ApplicationController

  # TODO: for now we'll use db based templates
  #before_filter :prepend_view_path_for_site
  before_filter :fetch_menu
  before_filter :fetch_templates


  helper_method :current_site




  def current_site
    s = Site.find_by_domain(request.domain)
    s = Site.default.first unless s
    s
  end

  protected
    def fetch_menu
      @menu_items = current_site ? current_site.menu_items.all : []
    end

    def fetch_templates
      @layout_template = current_site.templates.where('name=?', 'layout').first
      @page_template = current_site.templates.where('name=?', 'page').first
    end

    def prepend_view_path_for_site
      # todo performance issue here - templates are cached on each request. lame.
      logger.info "current_site.domain"
      s = current_site
      self.prepend_view_path(File.join(::Rails.root.to_s, 'app', 'views', s.domain)) unless s.blank?
      logger.info self.view_paths.join("\n")

    end

end
