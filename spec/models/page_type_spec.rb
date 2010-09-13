require 'spec_helper'

describe PageType do

  before(:each) do
    PageType.delete_all
    @site = Site.create!(:title=>"Google", :domain=>"google.com")
    @valid = {:name=>"test item", :slug=>"test_slug"}
  end

  it "should be valid with proper parameters" do
    pt = PageType.new(@valid)
    pt.site = @site
    pt.should be_valid
  end

  it "should automagically generate slug" do
    pt = PageType.new(@valid)
    pt.site = @site
    pt.slug = nil
    pt.save!
    pt.slug.should_not be_nil
  end

  it "should be only valid when title and site are provided" do
    pt = PageType.new(@valid)
    pt.should_not be_valid
    pt = PageType.new
    pt.site = @site
    pt.should_not be_valid
  end
end
