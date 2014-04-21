require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'askaway'" do
      visit root_path
      expect(page).to have_content('askaway')
    end
  end
  describe "Help page" do

    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end
  end
  describe "About page" do

    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
  end
end