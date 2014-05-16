require 'spec_helper'

feature 'happy path' do
  scenario 'user can save their dietary preferences and see them on their page' do
    VCR.use_cassette('happy_path', :record => :all) do
      pending
      sign_in_user
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      select "Highlands, Denver", :from => "restaurant[location]"
      click_on "Add this Restaurant"
      visit '/'
      select "Pearl Street, Boulder", :from => "homepage_location"
      check("option[gluten free options]")
      check("option[dairy free options]")
      check("save[true]")
      click_on "Go"
      click_on 'my page'
      expect(page).to have_content 'My Page'
      expect(page).to have_content 'My preferences: '
    end
  end

  scenario "User can visit their page and see their restaurants" do
    VCR.use_cassette('happy_path/stuff', :record => :all) do
      sign_in_user
      restaurant = Restaurant.create!(name: "Linger", location: "Pearl Street, Boulder", dietary_option_list: "dairy free options")
      visit restaurant_path(restaurant)
      click_on "Favorite this restaurant"
      click_on "My Profile"
      expect(page).to have_content "Linger"
    end
  end
end