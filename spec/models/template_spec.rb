require 'spec_helper'

describe Template do
  before(:each) do
    Template.delete_all
    @site = Site.create!(:title=>"Google", :domain=>"google.com")
    @valid = {:name=>"test"}
  end

  it "should be valid for proper params" do
    t = Template.new(@valid)
    t.site = @site
    t.should be_valid
  end

  it "have to be unique per site" do
    s2 = Site.create!(:title=>"Google.pl", :domain=>"google.pl")
    t1 = Template.new(@valid)
    t1.site = @site
    t1.save!
    t1.should be_valid
    t2 = Template.new(@valid)
    t2.site = @site
    t2.should_not be_valid
    t3 = Template.new(@valid)
    t3.site = s2
    t3.should be_valid
  end
end
