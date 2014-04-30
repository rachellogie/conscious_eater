require 'spec_helper'

feature 'Restaurants manager' do
  scenario 'User can click a link from the homepage and see all the restaurants' do
    visit '/'
    click_on "All Restaurants"
    expect(page).to have_content "These are all the restaurants"
  end
end