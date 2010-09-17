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
    @page = current_site.pages.find(params[:id])
  end

end
