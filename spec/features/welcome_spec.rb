require 'spec_helper'

feature 'Homepage' do
  before do
    sign_up_user
  end

  scenario 'User can search by location' do
    VCR.use_cassette('welcome/search') do
      visit root_path
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      select "Highlands, Denver", :from => "restaurant[location]"
      click_on "Add this Restaurant"

      visit root_path
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Shine"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      select "Pearl Street, Boulder", :from => "restaurant[location]"
      click_on "Add this Restaurant"

      visit restaurants_path
      expect(page).to have_content "Shine"
      expect(page).to have_content "Linger"

      visit root_path
      select "Pearl Street, Boulder", :from => "homepage_location"
      check("option[gluten free options]")
      click_on "Go"
      expect(page).to have_content "Shine"
      expect(page).to_not have_content "Linger"
    end
  end

  scenario 'user can click the pick for me button and it will show a random restaurant' do
    VCR.use_cassette('welcome/random_pick') do
      restaurant = Restaurant.create!(name: "Linger", location: "Highlands, Denver", dietary_option_list: "dairy free options")
      visit '/'
      expect(page).to_not have_content "Linger"
      click_on "Surprise me"
      expect(page).to have_content "Linger"
    end
  end

end