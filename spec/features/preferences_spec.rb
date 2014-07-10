require 'spec_helper'

feature 'preferences' do
  scenario 'When user clicks save my preferences, it should overwrite previous preferences' do
    VCR.use_cassette('preferences/overwrite') do
      sign_up_user
      create_restaurant
      visit root_path
      select 'Pearl Street, Boulder', :from => 'homepage_location'
      check('option[gluten free options]')
      check('option[dairy free options]')
      check('save')
      click_on 'Go'
      click_on 'My Profile'
      expect(page).to have_content 'My preferences:'
      expect(page).to have_content 'gluten free options'
      expect(page).to have_content 'dairy free options'

      visit root_path
      select 'Pearl Street, Boulder', :from => 'homepage_location'
      uncheck('option[gluten free options]')
      uncheck('option[dairy free options]')
      check('option[vegetarian options]')
      check('option[vegan options]')
      check('save')
      click_on 'Go'
      click_on 'My Profile'
      expect(page).to_not have_content 'gluten free options'
      expect(page).to_not have_content 'dairy free options'
      expect(page).to have_content 'vegetarian options'
      expect(page).to have_content 'vegan options'
    end
  end
end
