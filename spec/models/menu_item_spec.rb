require 'spec_helper'

describe MenuItem do
  before(:each) do
    MenuItem.delete_all
    @site = Site.create!(:title=>"Google", :domain=>"google.com")
    @site.menu_items.delete_all
    @valid = {:name=>"test menu item"}
  end

  it "should be valid with valid attributes" do
    @menu_item = MenuItem.new(@valid)
    @menu_item.site = @site
    @menu_item.should be_valid
  end

  it "should not be valid when at provided parameters are not ok" do
    @menu_item = MenuItem.new(@valid)
    @menu_item.should_not be_valid
    @menu_item = MenuItem.new(@valid)
    @menu_item.position = nil
    @menu_item.should_not be_valid
    @menu_item = MenuItem.new(@valid)
    @menu_item.position = "test"
    @menu_item.should_not be_valid
    @menu_item = MenuItem.new(@valid)
    @menu_item.target = nil
    @menu_item.should_not be_valid
    @menu_item = MenuItem.new(@valid)
    @menu_item.target = "test"
    @menu_item.should_not be_valid
  end


  it "should be marked as landing if this is first menu_item in site" do
    @menu_item = MenuItem.new(@valid)
    @menu_item.site = @site
    @menu_item.save!
    @menu_item.reload
    @menu_item.is_landing.should == true
  end

  it "should keep only one default site in system" do
    mi1 = MenuItem.new(@valid)
    mi1.site = @site
    mi1.save!
    mi2 = MenuItem.new(@valid)
    mi2.site = @site
    mi2.is_landing = true
    mi2.save!
    mi1.reload
    mi1.is_landing.should == false
  end

  it "should not change default site when not asked to" do
    mi1 = MenuItem.new(@valid)
    mi1.site = @site
    mi1.save!
    mi2 = MenuItem.new(@valid)
    mi2.site = @site
    mi2.save!


    # second site
    s = Site.create!(:title=>"Google.pl", :domain=>"google.pl")
    s.menu_items.delete_all
    mi3 = MenuItem.new(@valid)
    mi3.site = s
    mi3.save!
    mi4 = MenuItem.new(@valid)
    mi4.site = s
    mi4.save!

    mi1.reload
    mi2.reload
    mi3.reload
    mi4.reload
    mi1.is_landing.should == true
    mi2.is_landing.should == false
    mi3.is_landing.should == true
    mi4.is_landing.should == false
  end
end
