require 'spec_helper'


describe 'welcome helper' do

  it 'returns true if the user has that preference' do
    user = User.create!(email: 'bob@bob.com', password: 'password')
    user.preferences.create(preference_name: 'vegan options')
    checked = WelcomeHelper.see_if_checked('vegan options', user)
    expect(checked).to eq true
  end
end