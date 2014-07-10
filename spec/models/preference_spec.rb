require 'spec_helper'

describe Preference do
  it 'can save preferences for a user' do
    user = create_user('bob@example.com')
    expect(user.preferences.first).to eq nil
    options_params = {"gluten free options"=>"yes", "dairy free options"=>"yes"}
    Preference.save_preferences_for(user, options_params)
    preference_names =  user.preferences.map { |preference| preference.preference_name}
    expect(preference_names).to match_array(["gluten free options", "dairy free options"])

    options_params2 = {"organic ingredients"=>"yes", "vegan options"=>"yes"}
    Preference.save_preferences_for(user, options_params2)
    preference_names2 =  user.preferences.map { |preference| preference.preference_name}
    expect(preference_names2).to match_array(["organic ingredients", "vegan options"])
  end
end
