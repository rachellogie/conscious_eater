require 'spec_helper'

feature 'User authentication' do

  before :each do
    VCR.use_cassette('users/before') do
      sign_up_user
      visit '/restaurants'
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      click_on "Sign out"
    end
  end

  scenario 'User can sign in' do
    sign_in_user
    expect(page).to have_content "Welcome bob@example.com"
  end

  scenario 'non signed in users cannot add a restaurant' do
    visit '/restaurants'
    click_on 'see restaurant'
    expect(page).to_not have_button 'delete'
  end

  scenario 'non signed in users cannot update a restaurant' do
    visit '/restaurants'
    click_on 'see restaurant'
    expect(page).to_not have_content 'Edit Restaurant Information'
  end

  scenario 'non admin cannot delete a restaurant' do
    sign_in_user
    visit '/restaurants'
    click_on 'see restaurant'
    expect(page).to_not have_button 'delete'

  end

end