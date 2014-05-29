require 'spec_helper'

feature 'Facts' do

  scenario 'user can add a fact and see it on that restaurant page and delete their own fact' do
    sign_up_user
    create_restaurant
    visit '/'
    click_on 'Go'
    click_on 'Linger'
    click_on 'Add Fact'
    fill_in 'fact[body]', with: '75% of the menu is organic'
    click_on 'Add Fact'
    expect(page).to have_content '75% of the menu is organic'
    expect(page).to have_content 'Added by bob'
  end

end