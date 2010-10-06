class Admin::PagesController < AdminController
  include TinymceFilemanager
  link_classes_accepted [Page]
  # GET /pages
  # GET /pages.xml
  def index
    @pages = current_site.pages.without_type.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = current_site.pages.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new
    unless params[:page_type].blank?
      @page_type = current_site.page_types.find(params[:page_type])
      @page.page_type = @page_type
      for property_type in @page_type.property_types
        property = property_type.properties.new(:property_type_id=>property_type.id)
        property.page_type = @page_type
        @page.properties << property
      end
      @page.show_on_lists = @page_type.show_on_lists
      @page.show_in_menu = @page.show_in_menu
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = current_site.pages.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    @page.site = current_site
    respond_to do |format|
      if @page.save
        format.html { redirect_to([:admin, @page], :notice => t('pages.notices.created', :default=>'Page was successfully created.')) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = current_site.pages.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to([:admin, @page], :notice => t('pages.notices.updated', :default=>'Page was successfully updated.')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = current_site.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_pages_url) }
      format.xml  { head :ok }
    end
  end
  
  def sort
    @page = current_site.pages.find(params[:id])
    @pages = @page.sub_pages.all
    @pages.each do |p|
      p.position = params['page'].index(p.id.to_s) + 1
      p.save
    end

    render :nothing => true
  end
end
