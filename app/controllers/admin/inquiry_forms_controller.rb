class Admin::InquiryFormsController < AdminController
  # GET /inquiry_forms
  # GET /inquiry_forms.xml
  def index
    @inquiry_forms = current_site.inquiry_forms.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inquiry_forms }
    end
  end

  # GET /inquiry_forms/1
  # GET /inquiry_forms/1.xml
  def show
    @inquiry_form = current_site.inquiry_forms.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inquiry_form }
    end
  end

  # GET /inquiry_forms/new
  # GET /inquiry_forms/new.xml
  def new
    @inquiry_form = InquiryForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inquiry_form }
    end
  end

  # GET /inquiry_forms/1/edit
  def edit
    @inquiry_form = current_site.inquiry_forms.find(params[:id])
  end

  # POST /inquiry_forms
  # POST /inquiry_forms.xml
  def create
    @inquiry_form = current_site.inquiry_forms.new(params[:inquiry_form])

    respond_to do |format|
      if @inquiry_form.save
        format.html { redirect_to([:admin, @inquiry_form], :notice => 'Inquiry form was successfully created.') }
        format.xml  { render :xml => @inquiry_form, :status => :created, :location => @inquiry_form }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inquiry_form.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inquiry_forms/1
  # PUT /inquiry_forms/1.xml
  def update
    @inquiry_form = current_site.inquiry_forms.find(params[:id])

    respond_to do |format|
      if @inquiry_form.update_attributes(params[:inquiry_form])
        format.html { redirect_to([:admin, @inquiry_form], :notice => 'Inquiry form was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inquiry_form.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiry_forms/1
  # DELETE /inquiry_forms/1.xml
  def destroy
    @inquiry_form = current_site.inquiry_forms.find(params[:id])
    @inquiry_form.destroy

    respond_to do |format|
      format.html { redirect_to(admin_inquiry_forms_url) }
      format.xml  { head :ok }
    end
  end
end
