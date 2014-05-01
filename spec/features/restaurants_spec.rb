require 'spec_helper'

feature 'Restaurants manager' do
  scenario 'User can click a link from the homepage and see all the restaurants' do
    visit '/'
    click_on "All Restaurants"
    expect(page).to have_content "These are all the restaurants"
  end

  scenario 'User can add a restaurant' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Linger"
    fill_in "restaurant[website]", with: "linger.com"
    check("restaurant[gluten_free_options]")
    click_on "Add this Restaurant"
    expect(page).to have_content "Linger"
    expect(page).to have_content "Gluten free options: true"
  end

  scenario 'User can update a restaurant' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Linger"
    fill_in "restaurant[website]", with: "linger.com"
    check("restaurant[gluten_free_options]")
    click_on "Add this Restaurant"
    expect(page).to have_content "Dairy free options: false"

    click_on "Update Restaurant Information"
    check("restaurant[dairy_free_options]")
    click_on "Update"
    expect(page).to have_content "Dairy free options: true"
  end

end