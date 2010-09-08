class PagesController < GroovyContentController
  def index
    landing = current_site.menu_items.where('is_landing=?', true).first
    if landing
      if landing.linkable.class == Page
        @page = landing.linkable
        render :action=>"show"
      else
        redirect_to landing.url
      end
    end
  end

  def show
  end

end
