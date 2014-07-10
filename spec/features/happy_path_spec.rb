require 'spec_helper'


feature 'happy path' do

  before do
    sign_up_user
  end

  scenario 'user can save their dietary preferences and see them on their page' do
    VCR.use_cassette('happy_path/see_preferences') do
      create_restaurant
      visit '/'
      select "Pearl Street, Boulder", :from => "homepage_location"
      check("option[gluten free options]")
      check("option[dairy free options]")
      check("save")
      click_on "Go"
      click_on 'My Profile'
      expect(page).to have_content 'My preferences:'
      expect(page).to have_content 'gluten free options'
      expect(page).to have_content 'dairy free options'
    end
  end

  scenario "User can visit their page and see their restaurants" do
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    click_on "Favorite this restaurant"
    click_on "My Profile"
    expect(page).to have_content "Linger"
  end

end