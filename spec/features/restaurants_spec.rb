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
    check("option[gluten free]")
    click_on "Add this Restaurant"
    expect(page).to have_content "Linger"
    expect(page).to have_content "gluten free"
  end

  scenario 'User can update a restaurant' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Linger"
    fill_in "restaurant[website]", with: "linger.com"
    check("option[gluten free]")
    click_on "Add this Restaurant"
    expect(page).to have_content "gluten free"
    click_on "Update Restaurant Information"
    select "Pearl", :from => "restaurant[location]"
    uncheck("option[gluten free]")
    check("option[dairy free]")
    click_on "Update"
    expect(page).to_not have_content "gluten free"
    expect(page).to have_content "dairy free"
    expect(page).to have_content "Pearl"
  end

  scenario 'User can return to all restaurants from an individual restaurant page' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Linger"
    fill_in "restaurant[website]", with: "linger.com"
    check("option[gluten free]")
    click_on "Add this Restaurant"
    click_on "Take me back to the restaurant list"
    expect(page).to have_content "These are all the restaurants"
  end

  scenario 'User can delete a restaurant' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Linger"
    fill_in "restaurant[website]", with: "linger.com"
    check("option[vegan]")
    click_on "Add this Restaurant"
    click_on "delete"
    expect(page).to_not have_content "Linger"
  end

  scenario 'User cannot add a restaurant without at least 1 dietary option' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[name]", with: "Linger"
    fill_in "restaurant[website]", with: "linger.com"
    click_on "Add this Restaurant"
    expect(page).to have_content "You must check at least 1 diet option"
  end

  scenario 'User will see errors if they try to create a restaurant without a name' do
    visit '/'
    click_on "All Restaurants"
    click_on "Add a Restaurant"
    fill_in "restaurant[website]", with: "linger.com"
    check("option[vegan]")
    click_on "Add this Restaurant"
    expect(page).to have_content "Name can't be blank"
  end



end