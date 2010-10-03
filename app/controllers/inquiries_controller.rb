class InquiriesController < GroovyContentController
  def new
    inquiry_form = current_site.inquiry_forms.find_by_slug!(params[:form])
    @inquiry = Inquiry.new
    @inquiry.inquiry_form = inquiry_form
    for inf in inquiry_form.inquiry_fields
      inquiry_value = inf.inquiry_values.new(:inquiry_field_id=>inf.id)
      inquiry_value.inquiry_form = inquiry_form
      @inquiry.inquiry_values << inquiry_value
    end
  end
  
  def create
    @inquiry = Inquiry.new(params[:inquiry])
    @inquiry.site = current_site
    respond_to do |format|
      if @inquiry.save
        # It's bad, I know...
        render :action => "create"
      else
        render :action => "new" 
      end
    end
  end

end
