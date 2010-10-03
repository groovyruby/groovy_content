require 'spec_helper'

describe Admin::InquiryFormsController do
  include Devise::TestHelpers
  fixtures :users, :sites, :page_types, :property_types

  before(:each) do
    @user = users(:admin)
    @site = sites(:one)
    #Site.stub(:find).and_return(@site)
    sign_in @user
    session[:site] = @site.id
  end
  
  def mock_inquiry_form(stubs={})
    @mock_inquiry_form ||= mock_model(InquiryForm, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all inquiry_forms as @inquiry_forms" do
      mif = mock_inquiry_form
      controller.stub_chain(:current_site, :inquiry_forms, :all).and_return([mif])
      get :index
      assigns(:inquiry_forms).should eq([mock_inquiry_form])
    end
  end

  describe "GET show" do
    it "assigns the requested inquiry_form as @inquiry_form" do
      mif = mock_inquiry_form
      controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
      get :show, :id => "37"
      assigns(:inquiry_form).should be(mock_inquiry_form)
    end
  end

  describe "GET new" do
    it "assigns a new inquiry_form as @inquiry_form" do
      InquiryForm.stub(:new) { mock_inquiry_form }
      get :new
      assigns(:inquiry_form).should be(mock_inquiry_form)
    end
  end

  describe "GET edit" do
    it "assigns the requested inquiry_form as @inquiry_form" do
      mif = mock_inquiry_form
      controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
      get :edit, :id => "37"
      assigns(:inquiry_form).should be(mock_inquiry_form)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created inquiry_form as @inquiry_form" do
        InquiryForm.stub(:new).with({'these' => 'params'}) { mock_inquiry_form(:save => true) }
        post :create, :inquiry_form => {'these' => 'params'}
        assigns(:inquiry_form).should be(mock_inquiry_form)
      end

      it "redirects to the created inquiry_form" do
        InquiryForm.stub(:new) { mock_inquiry_form(:save => true) }
        post :create, :inquiry_form => {}
        response.should redirect_to(admin_inquiry_form_url(mock_inquiry_form))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved inquiry_form as @inquiry_form" do
        InquiryForm.stub(:new).with({'these' => 'params'}) { mock_inquiry_form(:save => false) }
        post :create, :inquiry_form => {'these' => 'params'}
        assigns(:inquiry_form).should be(mock_inquiry_form)
      end

      it "re-renders the 'new' template" do
        InquiryForm.stub(:new) { mock_inquiry_form(:save => false) }
        post :create, :inquiry_form => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested inquiry_form" do
        mif = mock_inquiry_form
        controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
        mock_inquiry_form.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :inquiry_form => {'these' => 'params'}
      end

      it "assigns the requested inquiry_form as @inquiry_form" do
        mif = mock_inquiry_form(:update_attributes => true)
        controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
        put :update, :id => "1"
        assigns(:inquiry_form).should be(mock_inquiry_form)
      end

      it "redirects to the inquiry_form" do
        mif = mock_inquiry_form(:update_attributes => true)
        controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
        put :update, :id => "1"
        response.should redirect_to(admin_inquiry_form_url(mock_inquiry_form))
      end
    end

    describe "with invalid params" do
      it "assigns the inquiry_form as @inquiry_form" do
        mif = mock_inquiry_form(:update_attributes => false)
        controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
        put :update, :id => "1"
        assigns(:inquiry_form).should be(mock_inquiry_form)
      end

      it "re-renders the 'edit' template" do
        mif = mock_inquiry_form(:update_attributes => false)
        controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested inquiry_form" do
      mif = mock_inquiry_form
      controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
      mock_inquiry_form.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the inquiry_forms list" do
      mif = mock_inquiry_form
      controller.stub_chain(:current_site, :inquiry_forms, :find).and_return(mif)
      delete :destroy, :id => "1"
      response.should redirect_to(admin_inquiry_forms_url)
    end
  end

end
