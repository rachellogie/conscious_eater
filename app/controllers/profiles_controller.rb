class ProfilesController < ApplicationController

  def show
    @favorite_restaurants = current_user.restaurants
    @preferences = current_user.preferences
  end
end