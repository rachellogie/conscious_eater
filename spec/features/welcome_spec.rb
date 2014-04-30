require 'spec_helper'

feature 'Homepage' do

  scenario 'User can see app name on the homepage' do
    visit '/'
    expect(page).to have_content "The Conscious Eater"
  end

end