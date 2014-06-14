require 'spec_helper'
require 'requests/rails_helper'


feature 'favorite restaurants' do

  scenario 'user can remove a favorite restaurant from their list on their profile page' do
    sign_up_user
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    click_on "Favorite this restaurant"
    user = User.find_by(email: 'bob@example.com')
    visit profile_path(user)
    click_on "Remove from favorites"
    expect(page).to_not have_content "Linger"
  end

  scenario 'number of favorites will be displayed on restaurant show page' do
    sign_up_user
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    expect(page).to have_content "0"
    click_on "Favorite this restaurant"
    expect(page).to have_content "1"
  end

end