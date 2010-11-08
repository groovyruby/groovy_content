class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource
  
  before_filter :set_forgery_param
  before_filter :set_current_user
  
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
  
  def set_forgery_param
    @forgery_token = form_authenticity_token
  end
  
  def set_current_user
    @current_user = current_user
  end


end
