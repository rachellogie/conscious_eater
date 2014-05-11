require 'spec_helper'

feature 'User authentication' do

  before :each do
    VCR.use_cassette('users/before') do
      visit '/'
      click_on 'Sign in'
      click_on 'Sign up'
      fill_in 'Email', with: 'bob@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      visit '/restaurants'
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      click_on "Sign out"
    end
  end

  scenario 'User can sign in' do
    visit '/'
    click_on 'Sign in'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
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

end