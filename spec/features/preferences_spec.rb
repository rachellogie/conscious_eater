require 'spec_helper'

feature 'preferences' do
  scenario 'When user clicks save my preferences, it should overwrite previous preferences' do
    VCR.use_cassette('preferences/not_duplicate') do
      sign_up_user
      restaurant = Restaurant.create!(name: "Linger", location: "Pearl Street, Boulder", dietary_option_list: "dairy free options")
      visit '/'
      select "Pearl Street, Boulder", :from => "homepage_location"
      check("option[gluten free options]")
      check("option[dairy free options]")
      check("save")
      click_on "Go"
      click_on 'My Profile'
      expect(page).to have_content 'Here are all your favorite restaurants:'
      expect(page).to have_content 'These are your preferences:'
      expect(page).to have_content 'gluten free options'
      expect(page).to have_content 'dairy free options'

      visit '/'
      select "Pearl Street, Boulder", :from => "homepage_location"
      check("option[vegetarian options]")
      check("option[vegan options]")
      check("save")
      click_on "Go"
      click_on 'My Profile'
      expect(page).to_not have_content 'gluten free options'
      expect(page).to_not have_content 'dairy free options'
      expect(page).to have_content 'vegetarian options'
      expect(page).to have_content 'vegan options'
    end
  end
end
