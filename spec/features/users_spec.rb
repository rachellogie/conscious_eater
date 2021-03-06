require 'spec_helper'


feature 'User authorizations' do

  before :each do
    sign_up_user
    @restaurant = create_restaurant
    click_on 'Sign out'
  end

  scenario 'User can sign in' do
    sign_in_user
    expect(page).to have_content 'Welcome bob@example.com'
  end

  scenario 'non signed in users cannot add a restaurant' do
    visit restaurant_path(@restaurant)
    expect(page).to_not have_button 'delete'
  end

  scenario 'non signed in users cannot update a restaurant' do
    visit restaurant_path(@restaurant)
    expect(page).to_not have_content 'Edit Restaurant Information'
  end

  scenario 'non admin cannot delete a restaurant' do
    visit restaurant_path(@restaurant)
    expect(page).to_not have_button 'delete'
  end

  scenario 'non signed in users cant save dietary options' do
    visit root_path
    expect(page).to_not have_content 'Save my dietary preferences'
  end

end