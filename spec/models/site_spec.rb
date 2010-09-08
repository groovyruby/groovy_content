require 'spec_helper'

describe Site do
  before(:each) do
    Site.delete_all
    @valid = {:title=>"Google", :domain=>"google.com"}
  end

  it "should be valid with valid attributes" do
    @site = Site.new(@valid)
    @site.should be_valid
  end

  it "should not be valid when at least one of parameters is blank" do
    @site = Site.new(@valid)
    @site.title = ''
    @site.should_not be_valid
    @site = Site.new(@valid)
    @site.domain = ''
    @site.should_not be_valid
    @site = Site.new(@valid)
    @site.title = ''
    @site.domain = ''
    @site.should_not be_valid
  end

  it "should keep only unique records" do
    s1 = Site.create(@valid)
    s2 = Site.new(@valid)
    s2.should_not be_valid
    s3 = Site.new(@valid)
    s3.title = "test"
    s3.should_not be_valid
    s4 = Site.new(@valid)
    s4.domain = "test.domain.com"
    s4.should_not be_valid
  end

  it "should accept only valid domains" do
    @site = Site.new(@valid)
    @site.domain = 'test.groovyruby.pl'
    @site.should be_valid
    @site.domain = 'a.pl'
    @site.should be_valid
    @site.domain = 'groovyru.by'
    @site.should be_valid
    @site.domain = '.groovyru.by'
    @site.should_not be_valid
    @site.domain = 'groovyru.bybyby'
    @site.should_not be_valid
  end

  it "should be marked as default if this is first site in app" do
    @site = Site.new(@valid)
    @site.save!
    @site.reload
    @site.is_default.should == true
  end

  it "should keep only one default site in system" do
    s1 = Site.create(@valid)
    Site.create({:title=>"test", :domain=>"test.domain.com", :is_default=>true})
    s1.reload
    s1.is_default.should == false
  end

  it "should not change default site when not asked to" do
    s1 = Site.create(@valid)
    s2 = Site.create({:title=>"test", :domain=>"test.domain.com", :is_default=>false})
    s1.reload
    s2.reload
    s1.is_default.should == true
    s2.is_default.should == false
  end

  it "should create related records" do
    s1 = Site.create(@valid)
    s1.reload
    s1.templates.where("name=?", "layout").first.should_not be_nil
    s1.templates.where("name=?", "page").first.should_not be_nil
    s1.templates.where('name=?', 'head').first.should_not be_nil
    s1.menu_items.where('name=?', 'home page').first.should_not be_nil
    s1.pages.where('title=?', 'Home page').first.should_not be_nil
  end
end
