require 'spec_helper'

describe Admin::DashboardController do
  include Devise::TestHelpers
  fixtures :users

  before(:each) do
    @user = users(:admin)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
