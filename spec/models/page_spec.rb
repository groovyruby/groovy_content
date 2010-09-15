require 'spec_helper'

describe Page do

  before(:each) do
    Page.delete_all
    @site = Site.create!(:title=>"Google", :domain=>"google.com")
    @valid = {:title=>"test menu item", :slug=>"test_slug"}
  end

  it "should be valid with proper parameters" do
    p = Page.new(@valid)
    p.site = @site
    p.should be_valid
  end

  it "should automagically generate slug" do
    p = Page.new(@valid)
    p.site = @site
    p.slug = nil
    p.save!
    p.slug.should_not be_nil
  end

  it "should be only valid when title and site are provided" do
    p = Page.new(@valid)
    p.should_not be_valid
    p = Page.new
    p.site = @site
    p.should_not be_valid
  end

end
