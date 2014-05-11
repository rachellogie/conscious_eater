require 'spec_helper'

feature 'User authentication' do

  scenario 'User can sign in' do
    visit '/'
    click_on 'Sign in'
    click_on 'Sign up'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content "Welcome bob@example.com"
  end

  scenario 'Only signed in users can add a restaurant' do
    visit '/restaurants'
    expect(page).to_not have_content 'Add a Restaurant'
  end

end