module WelcomeHelper

  def self.see_if_checked(option, user)
    if user
      return user.preferences.exists?(preference_name: option)
    else
      false
    end
  end
end