class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  before_filter :get_sites
  

  layout "admin"


  private
  
  def require_admin
    redirect_to(root_url) unless current_user.is_admin?
  end
  def get_sites
    @sites = Site.all
  end


end
