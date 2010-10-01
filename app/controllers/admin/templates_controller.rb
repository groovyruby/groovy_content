class Admin::TemplatesController < AdminController
  # GET /templates
  # GET /templates.xml
  def index
    @templates = current_site.templates.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @templates }
    end
  end

  # GET /templates/1
  # GET /templates/1.xml
  def show
    @template = current_site.templates.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @template }
    end
  end

  # GET /templates/new
  # GET /templates/new.xml
  def new
    @template = Template.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @template }
    end
  end

  # GET /templates/1/edit
  def edit
    @template = current_site.templates.find(params[:id])
  end

  # POST /templates
  # POST /templates.xml
  def create
    @template = Template.new(params[:template])
    @template.site = current_site
    respond_to do |format|
      if @template.save
        format.html { redirect_to([:admin, @template], :notice => t('templates.notices.created', :default=>'Template was successfully created.')) }
        format.xml  { render :xml => @template, :status => :created, :location => @template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /templates/1
  # PUT /templates/1.xml
  def update
    @template = current_site.templates.find(params[:id])
    params[:template].delete(:name) unless @template.is_deletable?
    respond_to do |format|
      if @template.update_attributes(params[:template])
        format.html { redirect_to([:admin, @template], :notice => t('templates.notices.updated', :default=>'Template was successfully updated.')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.xml
  def destroy
    @template = current_site.templates.find(params[:id])


    respond_to do |format|
      if @template.is_deletable?
        @template.destroy
        format.html { redirect_to(admin_templates_url) }
        format.xml  { head :ok }
      else
        format.html { render :action=>"show", :notice=>"Template is undeletable"}
        format.xml { render :error, :status=>:unprocessable_entity}
      end
    end
  end
end
