class Preference < ActiveRecord::Base

  def self.save_preferences_for(user, options)
    user.preferences.destroy_all
    options.each do |preference|
      user.preferences.create(preference_name: preference.first)
    end
  end

end