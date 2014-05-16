require 'spec_helper'

feature 'Restaurants manager' do

  before do
    visit '/'
    visit '/'
    click_on 'Sign in'
    click_on 'Sign up'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
  end

  scenario 'User can click a link from the homepage and see all the restaurants' do
    visit '/'
    click_on "All Restaurants"
    expect(page).to have_content "These are all the restaurants"
  end

  scenario 'User can add a restaurant' do
    VCR.use_cassette('restaurants/add') do
      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      expect(page).to have_content "Linger"
      expect(page).to have_content "gluten free options"
    end
  end

  scenario 'User can update a restaurant' do
    VCR.use_cassette('restaurants/update') do
      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      expect(page).to have_content "gluten free"
      click_on "Edit Restaurant Information"
      select "Pearl", :from => "restaurant[location]"
      uncheck("option[gluten free options]")
      check("option[dairy free options]")
      click_on "Update"
      expect(page).to_not have_content "gluten free options"
      expect(page).to have_content "dairy free"
      expect(page).to have_content "Pearl"
    end
  end

  scenario 'User can return to all restaurants from an individual restaurant page' do
    VCR.use_cassette('restaurants/allrestaurants') do
      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      click_on "Take me back to the restaurant list"
      expect(page).to have_content "These are all the restaurants"
    end
  end

  scenario 'User cannot add a restaurant without at least 1 dietary option' do
    VCR.use_cassette('restaurants/adderrors') do
      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      click_on "Add this Restaurant"
      expect(page).to have_content "You must check at least 1 diet option"
    end
  end

  scenario 'User will see errors if they try to create a restaurant without a name' do
    VCR.use_cassette('restaurants/errors') do
      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[vegan options]")
      click_on "Add this Restaurant"
      expect(page).to have_content "Name can't be blank"
    end
  end

  scenario 'User will see errors if they try to update a restaurant without diet options' do
    VCR.use_cassette('restaurants/errors2') do
      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      click_on "Add this Restaurant"
      expect(page).to have_content "gluten free options"
      click_on "Edit Restaurant Information"
      select "Pearl", :from => "restaurant[location]"
      uncheck("option[gluten free options]")
      click_on "Update"
      expect(page).to have_content "You must check at least 1 diet option"
    end
  end

  scenario 'User can add a restaurant that is not in google' do
    VCR.use_cassette('restaurants/addwithoutgoogle') do
      visit '/'
      click_on "All Restaurants"
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
      visit '/'
      click_on "All Restaurants"
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
      visit '/'
      click_on "All Restaurants"
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
    VCR.use_cassette('restaurants/picks') do
      restaurant = Restaurant.create!(name: "Linger", location: "Pearl Street, Boulder", dietary_option_list: "gluten free options")
      visit restaurant_path(restaurant)
      click_on "Favorite this restaurant"
      expect(page).to have_content "Restaurant has been favorited!"
      #FavoriteRestaurant.last.restaurant = restaurant
    end
  end
end