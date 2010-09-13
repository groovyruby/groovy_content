require 'spec_helper'

describe Admin::PageTypesController do
  include Devise::TestHelpers
  fixtures :users

  before(:each) do
    @user = users(:admin)
    @site = mock_model(Site)
    Site.stub(:find).and_return(@site)
    sign_in @user
    session[:site] = @site.id
  end

  def mock_page_type(stubs={})
    @mock_page_type ||= mock_model(PageType, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all page_types as @page_types" do
      mpt = mock_page_type
      controller.stub_chain(:current_site, :page_types, :all).and_return([mpt])
      get :index
      assigns(:page_types).should eq([mock_page_type])
    end
  end

  describe "GET show" do
    it "assigns the requested page_type as @page_type" do
      mpt = mock_page_type
      controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
      get :show, :id => "37"
      assigns(:page_type).should be(mock_page_type)
    end
  end

  describe "GET new" do
    it "assigns a new page_type as @page_type" do
      PageType.stub(:new) { mock_page_type }
      get :new
      assigns(:page_type).should be(mock_page_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested page_type as @page_type" do
      mpt = mock_page_type
      controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
      get :edit, :id => "37"
      assigns(:page_type).should be(mock_page_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created page_type as @page_type" do
        PageType.stub(:new).with({'these' => 'params'}) { mock_page_type(:save => true) }
        post :create, :page_type => {'these' => 'params'}
        assigns(:page_type).should be(mock_page_type)
      end

      it "redirects to the created page_type" do
        PageType.stub(:new) { mock_page_type(:save => true) }
        post :create, :page_type => {}
        response.should redirect_to(admin_page_type_url(mock_page_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved page_type as @page_type" do
        PageType.stub(:new).with({'these' => 'params'}) { mock_page_type(:save => false) }
        post :create, :page_type => {'these' => 'params'}
        assigns(:page_type).should be(mock_page_type)
      end

      it "re-renders the 'new' template" do
        PageType.stub(:new) { mock_page_type(:save => false) }
        post :create, :page_type => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested page_type" do
        mpt = mock_page_type
        controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
        mock_page_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :page_type => {'these' => 'params'}
      end

      it "assigns the requested page_type as @page_type" do
        mpt = mock_page_type(:update_attributes => true)
        controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
        put :update, :id => "1"
        assigns(:page_type).should be(mock_page_type)
      end

      it "redirects to the page_type" do
        mpt = mock_page_type(:update_attributes => true)
        controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
        put :update, :id => "1"
        response.should redirect_to(admin_page_type_url(mock_page_type))
      end
    end

    describe "with invalid params" do
      it "assigns the page_type as @page_type" do
        mpt = mock_page_type(:update_attributes => false)
        controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
        put :update, :id => "1"
        assigns(:page_type).should be(mock_page_type)
      end

      it "re-renders the 'edit' template" do
        mpt = mock_page_type(:update_attributes => false)
        controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested page_type" do
      mpt = mock_page_type
      controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
      mock_page_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the page_types list" do
      mpt = mock_page_type
      controller.stub_chain(:current_site, :page_types, :find).and_return(mpt)
      delete :destroy, :id => "1"
      response.should redirect_to(admin_page_types_url)
    end
  end

end
