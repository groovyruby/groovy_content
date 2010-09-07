class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_sites

  layout "admin"

  helper_method :current_site

  def get_sites
    @sites = Site.all
  end

  def current_site
    session[:site].blank? ? nil : Site.find(session[:site])
  end
end
