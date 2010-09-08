class GroovyContentController < ApplicationController

  # TODO: for now we'll use db based templates
  #before_filter :prepend_view_path_for_site

  helper_method :current_site

  def current_site
    s = Site.find_by_domain(request.domain)
    s = Site.default.first unless s
    s
  end

  def prepend_view_path_for_site
    # todo performance issue here - templates are cached on each request. lame.
    logger.info "current_site.domain"
    s = current_site
    self.prepend_view_path(File.join(::Rails.root.to_s, 'app', 'views', s.domain)) unless s.blank?
    logger.info self.view_paths.join("\n")

  end

end
