class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_sites

  layout "admin"



  def get_sites
    @sites = Site.all
  end


end
