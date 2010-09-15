class Admin::MenuItemsController < AdminController
  # GET /menu_items
  # GET /menu_items.xml
  def index
    @menu_items = current_site.menu_items.by_position.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_items }
    end
  end

  # GET /menu_items/1
  # GET /menu_items/1.xml
  def show
    @menu_item = current_site.menu_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu_item }
    end
  end

  # GET /menu_items/new
  # GET /menu_items/new.xml
  def new
    @menu_item = MenuItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item }
    end
  end

  # GET /menu_items/1/edit
  def edit
    @menu_item = current_site.menu_items.find(params[:id])
  end

  # POST /menu_items
  # POST /menu_items.xml
  def create
    @menu_item = MenuItem.new(params[:menu_item])
    @menu_item.site = current_site
    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to([:admin, @menu_item], :notice => 'Menu item was successfully created.') }
        format.xml  { render :xml => @menu_item, :status => :created, :location => @menu_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_items/1
  # PUT /menu_items/1.xml
  def update
    @menu_item = current_site.menu_items.find(params[:id])

    respond_to do |format|
      if @menu_item.update_attributes(params[:menu_item])
        format.html { redirect_to([:admin, @menu_item], :notice => 'Menu item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.xml
  def destroy
    @menu_item = current_site.menu_items.find(params[:id])
    @menu_item.destroy

    respond_to do |format|
      format.html { redirect_to(admin_menu_items_url) }
      format.xml  { head :ok }
    end
  end

  def sort
    @menu_items = current_site.menu_items.by_position.all
    @menu_items.each do |mi|
      mi.position = params['menu_item'].index(mi.id.to_s) + 1
      mi.save
    end

    render :nothing => true
  end
end
