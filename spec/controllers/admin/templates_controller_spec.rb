require 'spec_helper'

describe Admin::TemplatesController do
  include Devise::TestHelpers
  fixtures :users

  before(:each) do
    @user = users(:admin)
    @site = mock_model(Site)
    Site.stub(:find).and_return(@site)
    sign_in @user
    session[:site] = @site.id
  end


  def mock_template(stubs={})
    @mock_template ||= mock_model(Template, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all templates as @templates" do
      mt = mock_template
      controller.stub_chain(:current_site, :templates, :all).and_return([mt])
      get :index
      assigns(:templates).should eq([mock_template])
    end
  end

  describe "GET show" do
    it "assigns the requested template as @template" do
      mt = mock_template
      controller.stub_chain(:current_site, :templates, :find).and_return(mt)
      get :show, :id => "37"
      assigns(:template).should be(mock_template)
    end
  end

  describe "GET new" do
    it "assigns a new template as @template" do
      Template.stub(:new) { mock_template }
      get :new
      assigns(:template).should be(mock_template)
    end
  end

  describe "GET edit" do
    it "assigns the requested template as @template" do
      mt = mock_template
      controller.stub_chain(:current_site, :templates, :find).and_return(mt)
      get :edit, :id => "37"
      assigns(:template).should be(mock_template)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created template as @template" do
        Template.stub(:new).with({'these' => 'params'}) { mock_template(:save => true) }
        post :create, :template => {'these' => 'params'}
        assigns(:template).should be(mock_template)
      end

      it "redirects to the created template" do
        Template.stub(:new) { mock_template(:save => true) }
        post :create, :template => {}
        response.should redirect_to(admin_template_url(mock_template))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved template as @template" do
        Template.stub(:new).with({'these' => 'params'}) { mock_template(:save => false) }
        post :create, :template => {'these' => 'params'}
        assigns(:template).should be(mock_template)
      end

      it "re-renders the 'new' template" do
        Template.stub(:new) { mock_template(:save => false) }
        post :create, :template => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested template" do
        mt = mock_template
        controller.stub_chain(:current_site, :templates, :find).and_return(mt)
        mock_template.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :template => {'these' => 'params'}
      end

      it "assigns the requested template as @template" do
        mt = mock_template(:update_attributes => true)
        controller.stub_chain(:current_site, :templates, :find).and_return(mt)
        put :update, :id => "1"
        assigns(:template).should be(mock_template)
      end

      it "redirects to the template" do
        mt = mock_template(:update_attributes => true)
        controller.stub_chain(:current_site, :templates, :find).and_return(mt)
        put :update, :id => "1"
        response.should redirect_to(admin_template_url(mock_template))
      end
    end

    describe "with invalid params" do
      it "assigns the template as @template" do
        mt = mock_template(:update_attributes => false)
        controller.stub_chain(:current_site, :templates, :find).and_return(mt)
        put :update, :id => "1"
        assigns(:template).should be(mock_template)
      end

      it "re-renders the 'edit' template" do
        mt = mock_template(:update_attributes => false)
        controller.stub_chain(:current_site, :templates, :find).and_return(mt)
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested template" do
      mt = mock_template
      controller.stub_chain(:current_site, :templates, :find).and_return(mt)
      mock_template.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the templates list" do
      mt = mock_template
      controller.stub_chain(:current_site, :templates, :find).and_return(mt)
      delete :destroy, :id => "1"
      response.should redirect_to(admin_templates_url)
    end
  end

end
