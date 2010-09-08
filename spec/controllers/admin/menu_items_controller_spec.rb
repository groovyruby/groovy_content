require 'spec_helper'

describe Admin::MenuItemsController do
  include Devise::TestHelpers
  fixtures :users

  before(:each) do
    @user = users(:admin)
    @site = mock_model(Site)
    Site.stub(:find).and_return(@site)
    sign_in @user
    session[:site] = @site.id
  end

  def mock_menu_item(stubs={})
    @mock_menu_item ||= mock_model(MenuItem, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all menu_items as @menu_items" do
      mmi = mock_menu_item
      controller.stub_chain(:current_site, :menu_items, :all).and_return([mmi])
      get :index
      assigns(:menu_items).should eq([mock_menu_item])
    end
  end

  describe "GET show" do
    it "assigns the requested menu_item as @menu_item" do
      mmi = mock_menu_item
      controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
      get :show, :id => "37"
      assigns(:menu_item).should be(mock_menu_item)
    end
  end

  describe "GET new" do
    it "assigns a new menu_item as @menu_item" do
      MenuItem.stub(:new) { mock_menu_item }
      get :new
      assigns(:menu_item).should be(mock_menu_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested menu_item as @menu_item" do
      mmi = mock_menu_item
      controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
      get :edit, :id => "37"
      assigns(:menu_item).should be(mock_menu_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created menu_item as @menu_item" do
        MenuItem.stub(:new).with({'these' => 'params'}) { mock_menu_item(:save => true) }
        post :create, :menu_item => {'these' => 'params'}
        assigns(:menu_item).should be(mock_menu_item)
      end

      it "redirects to the created menu_item" do
        MenuItem.stub(:new) { mock_menu_item(:save => true) }
        post :create, :menu_item => {}
        response.should redirect_to(admin_menu_item_url(mock_menu_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved menu_item as @menu_item" do
        MenuItem.stub(:new).with({'these' => 'params'}) { mock_menu_item(:save => false) }
        post :create, :menu_item => {'these' => 'params'}
        assigns(:menu_item).should be(mock_menu_item)
      end

      it "re-renders the 'new' template" do
        MenuItem.stub(:new) { mock_menu_item(:save => false) }
        post :create, :menu_item => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested menu_item" do
        mmi = mock_menu_item
        controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
        mock_menu_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :menu_item => {'these' => 'params'}
      end

      it "assigns the requested menu_item as @menu_item" do
        mmi = mock_menu_item(:update_attributes => true)
        controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
        put :update, :id => "1"
        assigns(:menu_item).should be(mock_menu_item)
      end

      it "redirects to the menu_item" do
        mmi = mock_menu_item(:update_attributes => true)
        controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
        put :update, :id => "1"
        response.should redirect_to(admin_menu_item_url(mock_menu_item))
      end
    end

    describe "with invalid params" do
      it "assigns the menu_item as @menu_item" do
        mmi = mock_menu_item(:update_attributes => false)
        controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
        put :update, :id => "1"
        assigns(:menu_item).should be(mock_menu_item)
      end

      it "re-renders the 'edit' template" do
        mmi = mock_menu_item(:update_attributes => false)
        controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested menu_item" do
      mmi = mock_menu_item
      controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
      mock_menu_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the menu_items list" do
      mmi = mock_menu_item
      controller.stub_chain(:current_site, :menu_items, :find).and_return(mmi)
      delete :destroy, :id => "1"
      response.should redirect_to(admin_menu_items_url)
    end
  end

end
