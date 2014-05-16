require 'spec_helper'

feature 'happy path' do
  scenario 'user can save their dietary preferences and see them on their page' do
    VCR.use_cassette('happy_path', :record => :all) do
      pending
      visit '/'
      click_on 'Sign in'
      click_on 'Sign up'
      fill_in 'Email', with: 'bob@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      click_on "All Restaurants"
      click_on "Add a Restaurant"
      fill_in "restaurant[name]", with: "Linger"
      fill_in "restaurant[website]", with: "http://lingerdenver.com/"
      check("option[gluten free options]")
      select "Highlands, Denver", :from => "restaurant[location]"
      click_on "Add this Restaurant"

      visit '/'
      select "Pearl Street, Boulder", :from => "homepage_location"
      check("option[gluten free options]")
      check("option[dairy free options]")
      check("save[true]")

      click_on "Go"

      click_on 'my page'

      expect(page).to have_content 'My Page'
      expect(page).to have_content 'My preferences: '
    end


  end
end