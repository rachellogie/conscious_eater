require 'spec_helper'

feature 'Homepage' do

  scenario 'User can see app name on the homepage' do
    visit '/'
    expect(page).to have_content "The Conscious Eater"
  end

  scenario 'User can search by location' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Linger"
    fill_in "restaurant[website]", with: "linger.com"
    select "Highlands, Denver", :from => "restaurant[location]"
    click_on "Add this Restaurant"

    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Shine"
    fill_in "restaurant[website]", with: "shine.com"
    select "Pearl Street, Boulder", :from => "restaurant[location]"
    click_on "Add this Restaurant"

    visit '/restaurants'
    expect(page).to have_content "Shine"
    expect(page).to have_content "Linger"


    visit '/'
    select "Pearl Street, Boulder", :from => "homepage_location"
    click_on "Go"
    expect(page).to have_content "Shine"
    expect(page).to_not have_content "Linger"

  end

end