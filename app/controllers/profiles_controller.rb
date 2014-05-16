class ProfilesController < ApplicationController

  def show
    @favorite_restaurants = current_user.restaurants
  end
end