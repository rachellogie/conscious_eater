require 'spec_helper'
require 'requests/rails_helper'


feature 'User authentication' do

  before :each do
    VCR.use_cassette('users/before') do
      sign_up_user
      create_restaurant
      click_on 'Sign out'
    end
  end

  scenario 'User can sign in' do
    sign_in_user
    expect(page).to have_content 'Welcome bob@example.com'
  end

  scenario 'non signed in users cannot add a restaurant' do
    visit '/restaurants'
    click_on 'Linger'
    expect(page).to_not have_button 'delete'
  end

  scenario 'non signed in users cannot update a restaurant' do
    visit '/restaurants'
    click_on 'Linger'
    expect(page).to_not have_content 'Edit Restaurant Information'
  end

  scenario 'non admin cannot delete a restaurant' do
    sign_in_user
    visit '/restaurants'
    click_on 'Linger'
    expect(page).to_not have_button 'delete'
  end

  scenario 'non signed in users cant save dietary options' do
    visit '/'
    expect(page).to_not have_content 'Save my dietary preferences'
  end

end