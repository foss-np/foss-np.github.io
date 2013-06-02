require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the h1 'FOSS Nepal'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'FOSS Nepal')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "FOSS Nepal | Home")
    end
  end 

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                    :text => "FOSS Nepal | About Us")
    end
  end
end

