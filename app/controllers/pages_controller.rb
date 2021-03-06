class PagesController < GroovyContentController
  def index
    landing = current_site.menu_items.where('is_landing=?', true).first
    if landing
      unless landing.page.blank?
        @page = landing.page
        render :action=>"show"
      else
        redirect_to landing.url
      end
    end
  end

  def show
    @page = current_site.pages.where('slug=?', params[:id]).first
    @page = current_site.pages.find(params[:id]) if @page.blank?
    if @page.privacy_level > Page::PRIVACY_LEVELS[:public]
      return redirect_to(root_url) unless current_user
    end
    @notice = flash[:notice]
  end

end
