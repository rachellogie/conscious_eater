require 'spec_helper'

feature 'favorite restaurants' do

  scenario 'user can remove a favorite restaurant from their list on their profile page' do
    VCR.use_cassette('favorite_restaurants/delete') do
      sign_up_user
      restaurant = Restaurant.create!(name: "Linger", location: "Pearl Street, Boulder", dietary_option_list: "dairy free options")
      visit restaurant_path(restaurant)
      click_on "Favorite this restaurant"
      user = User.find_by(email: 'bob@example.com')
      visit profile_path(user)
      click_on "Remove from favorites"
      expect(page).to_not have_content "Linger"
    end
  end

  scenario 'number of favorites will be displayed on restaurant show page' do
    VCR.use_cassette('favorite_restaurants/faves') do
      sign_up_user
      restaurant = Restaurant.create!(name: "Linger", location: "Pearl Street, Boulder", dietary_option_list: "dairy free options")
      visit restaurant_path(restaurant)
      click_on "Favorite this restaurant"
      expect(page).to have_content "1 Favorite"
    end
  end

end