class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      @sites = Site.all
      "admin"
    else
      "application"
    end
  end





  helper_method :s, :current_site

  def current_site
    session[:site].blank? ? nil : Site.find(session[:site])
  end

  private

  def s(identifier)
    Setting.get(identifier)
  end



end
