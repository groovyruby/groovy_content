require 'spec_helper'

describe Admin::PagesController do
  include Devise::TestHelpers
  fixtures :users

  before(:each) do
    @user = users(:admin)
    @site = mock_model(Site)
    Site.stub(:find).and_return(@site)
    sign_in @user
    session[:site] = @site.id
  end

  def mock_page(stubs={})
    @mock_page ||= mock_model(Page, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all pages as @pages" do
      mp = mock_page
      controller.stub_chain(:current_site, :pages, :all).and_return([mp])
      get :index
      assigns(:pages).should eq([mock_page])
    end
  end

  describe "GET show" do
    it "assigns the requested page as @page" do
      mp = mock_page
      controller.stub_chain(:current_site, :pages, :find).and_return(mp)
      get :show, :id => "37"
      assigns(:page).should be(mock_page)
    end
  end

  describe "GET new" do
    it "assigns a new page as @page" do
      Page.stub(:new) { mock_page }
      get :new
      assigns(:page).should be(mock_page)
    end
  end

  describe "GET edit" do
    it "assigns the requested page as @page" do
      mp = mock_page
      controller.stub_chain(:current_site, :pages, :find).and_return(mp)
      get :edit, :id => "37"
      assigns(:page).should be(mock_page)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created page as @page" do
        Page.stub(:new).with({'these' => 'params'}) { mock_page(:save => true) }
        post :create, :page => {'these' => 'params'}
        assigns(:page).should be(mock_page)
      end

      it "redirects to the created page" do
        Page.stub(:new) { mock_page(:save => true) }
        post :create, :page => {}
        response.should redirect_to(admin_page_url(mock_page))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved page as @page" do
        Page.stub(:new).with({'these' => 'params'}) { mock_page(:save => false) }
        post :create, :page => {'these' => 'params'}
        assigns(:page).should be(mock_page)
      end

      it "re-renders the 'new' template" do
        Page.stub(:new) { mock_page(:save => false) }
        post :create, :page => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested page" do
        mp = mock_page
        controller.stub_chain(:current_site, :pages, :find).and_return(mp)
        mock_page.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :page => {'these' => 'params'}
      end

      it "assigns the requested page as @page" do
        mp = mock_page(:update_attributes => true)
        controller.stub_chain(:current_site, :pages, :find).and_return(mp)
        put :update, :id => "1"
        assigns(:page).should be(mock_page)
      end

      it "redirects to the page" do
        mp = mock_page(:update_attributes => true)
        controller.stub_chain(:current_site, :pages, :find).and_return(mp)
        put :update, :id => "1"
        response.should redirect_to(admin_page_url(mock_page))
      end
    end

    describe "with invalid params" do
      it "assigns the page as @page" do
        mp = mock_page(:update_attributes => false)
        controller.stub_chain(:current_site, :pages, :find).and_return(mp)
        put :update, :id => "1"
        assigns(:page).should be(mock_page)
      end

      it "re-renders the 'edit' template" do
        mp = mock_page(:update_attributes => false)
        controller.stub_chain(:current_site, :pages, :find).and_return(mp)
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested page" do
      mp = mock_page
      controller.stub_chain(:current_site, :pages, :find).and_return(mp)
      mock_page.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the pages list" do
      mp = mock_page
      controller.stub_chain(:current_site, :pages, :find).and_return(mp)
      delete :destroy, :id => "1"
      response.should redirect_to(admin_pages_url)
    end
  end

end
