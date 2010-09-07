class Admin::DashboardController < AdminController
  def index
  end

  def set_site_context
    s = Site.find(params[:site_id])
    session[:site] = s.id
    redirect_to admin_root_url
  end

end
