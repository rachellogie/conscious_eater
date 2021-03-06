require 'spec_helper'

feature 'Facts' do

  scenario 'user can add a fact and see it on that restaurant page and delete their own fact' do
    sign_up_user
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    fill_in 'fact[body]', with: '75% of the menu is organic'
    click_on 'Add Tidbit'
    expect(page).to have_content '75% of the menu is organic'
    expect(page).to have_content 'Added by bob'
    click_on 'Delete my tidbit'
    expect(page).to_not have_content '75% of the menu is organic'
  end

end