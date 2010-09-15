class Admin::PageTypesController < AdminController
  # GET /page_types
  # GET /page_types.xml
  def index
    @page_types = current_site.page_types.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_types }
    end
  end

  def list_type
    @page_type = current_site.page_types.find(params[:id])
    @pages = @page_type.pages
  end

  # GET /page_types/1
  # GET /page_types/1.xml
  def show
    @page_type = current_site.page_types.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_type }
    end
  end

  # GET /page_types/new
  # GET /page_types/new.xml
  def new
    @page_type = PageType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page_type }
    end
  end

  # GET /page_types/1/edit
  def edit
    @page_type = current_site.page_types.find(params[:id])
  end

  # POST /page_types
  # POST /page_types.xml
  def create
    @page_type = PageType.new(params[:page_type])
    @page_type.site = current_site
    respond_to do |format|
      if @page_type.save
        format.html { redirect_to([:admin, @page_type], :notice => 'Page type was successfully created.') }
        format.xml  { render :xml => @page_type, :status => :created, :location => @page_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /page_types/1
  # PUT /page_types/1.xml
  def update
    @page_type = current_site.page_types.find(params[:id])

    respond_to do |format|
      if @page_type.update_attributes(params[:page_type])
        format.html { redirect_to([:admin, @page_type], :notice => 'Page type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page_types/1
  # DELETE /page_types/1.xml
  def destroy
    @page_type = current_site.page_types.find(params[:id])
    @page_type.destroy

    respond_to do |format|
      format.html { redirect_to(admin_page_types_url) }
      format.xml  { head :ok }
    end
  end
end
