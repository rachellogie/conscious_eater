require 'spec_helper'

feature 'Homepage' do
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

  scenario 'User can see app name on the homepage' do
    visit '/'
    expect(page).to have_content "The Conscious Eater"
  end

  scenario 'User can search by location' do
    VCR.use_cassette('welcome/search') do
      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      select "Highlands, Denver", :from => "restaurant[location]"
      click_on "Add this Restaurant"

      visit '/'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Shine"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      select "Pearl Street, Boulder", :from => "restaurant[location]"
      click_on "Add this Restaurant"

      visit '/restaurants'
      expect(page).to have_content "Shine"
      expect(page).to have_content "Linger"


      visit '/'
      select "Pearl Street, Boulder", :from => "homepage_location"
      check("option[gluten free options]")
      click_on "Go"
      expect(page).to have_content "Shine"
      expect(page).to_not have_content "Linger"
    end
  end

end