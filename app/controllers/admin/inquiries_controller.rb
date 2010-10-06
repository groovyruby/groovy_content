class Admin::InquiriesController < AdminController
  
  # GET /inquiries/1
  # GET /inquiries/1.xml
  def show
    @inquiry = current_site.inquiries.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inquiry }
    end
  end


  # DELETE /inquiries/1
  # DELETE /inquiries/1.xml
  def destroy
    @inquiry = current_site.inquiries.find(params[:id])
    @inquiry_form = @inquiry.inquiry_form
    @inquiry.destroy

    respond_to do |format|
      format.html { redirect_to(list_type_admin_inquiry_form_url(@inquiry_form.id)) }
      format.xml  { head :ok }
    end
  end
  
end
