require 'spec_helper'

feature 'Restaurants manager' do

  before do
    sign_up_user
  end

  scenario 'User can add a restaurant' do
    VCR.use_cassette('restaurants/add') do
      visit restaurants_path
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      expect(page).to have_content "Linger"
      expect(page).to have_content "gluten free options"

      visit restaurants_path
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "shine"
      check("option[gluten free options]")
      select "Pearl Street, Boulder", :from => "restaurant[location]"
      click_on "Add this Restaurant"
      expect(page).to have_content "Shine Restaurant and Gathering Place"

      visit restaurants_path
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: ""
      check("option[gluten free options]")
      select "Pearl Street, Boulder", :from => "restaurant[location]"
      click_on "Add this Restaurant"
      expect(page).to have_content "Name can't be blank"
    end
  end

  scenario 'User can update a restaurant' do
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    expect(page).to have_content "gluten free"
    click_on "Edit Restaurant Information"
    select "Pearl Street, Boulder", :from => "restaurant[location]"
    uncheck("option[gluten free options]")
    check("option[dairy free options]")
    click_on "Update"
    expect(page).to_not have_content "gluten free options"
    expect(page).to have_content "dairy free"
    expect(page).to have_content "Pearl"
  end

  scenario 'User can return to all restaurants from an individual restaurant page' do
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    click_on "Take me back to the restaurant list"
    expect(page).to have_content "These are all the restaurants"
  end

  scenario 'User will see errors if they try to update a restaurant without diet options' do
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    expect(page).to have_content "gluten free options"
    click_on "Edit Restaurant Information"
    select "Pearl Street, Boulder", :from => "restaurant[location]"
    uncheck("option[gluten free options]")
    click_on "Update"
    expect(page).to have_content "You must check at least 1 diet option"

  end

  scenario 'User can add a restaurant that is not in google' do
    VCR.use_cassette('restaurants/addwithoutgoogle') do
      visit restaurants_path
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "bhsdg"
      fill_in "restaurant[website]", with: "http://bhsdg.com/"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      expect(page).to have_content "gluten free options"
      expect(page).to have_content "Bhsdg"
    end
  end

  scenario 'User can add a restaurant that has no website from google api' do
    VCR.use_cassette('restaurants/addthekitchen') do
      visit restaurants_path
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "kitchen"
      fill_in "restaurant[website]", with: "http://bhsdg.com/"
      select "Pearl Street, Boulder", :from => "restaurant[location]"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      expect(page).to have_content "The Kitchen"
      expect(page).to have_content "Boulder"
    end
  end

  scenario 'User can add address manually if not in google' do
    VCR.use_cassette('restaurants/addthekitchen') do
      visit restaurants_path
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "adfg"
      fill_in "restaurant[website]", with: "http://adfg.com/"
      select "Pearl Street, Boulder", :from => "restaurant[location]"
      check("option[gluten free options]")
      fill_in "restaurant[address]", with: "1039 Pearl Street, Boulder, CO"
      click_on "Add this Restaurant"
      expect(page).to have_content "Adfg"
      expect(page).to have_content "1039 Pearl Street"
    end
  end

  scenario 'User can add a restaurant to their restaurant pick and see it on their mypage' do
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    click_on "Favorite this restaurant"
    expect(page).to have_content "Restaurant has been favorited!"
  end

  scenario 'User can only favorite a restaurant once' do
    restaurant = create_restaurant
    visit restaurant_path(restaurant)
    click_on "Favorite this restaurant"
    expect(page).to have_content "Restaurant has been favorited!"
    click_on "Favorite this restaurant"
    expect(page).to have_content "You already have this as a favorite!"
    expect(page).to_not have_content "Restaurant has been favorited!"
  end

end