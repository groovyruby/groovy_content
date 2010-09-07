require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should display landing page" do
      get 'index'
      #assigns(:menu_item).is_landing.should == true
      #assigns(:page).should_not be_blank
    end
  end

end
