module ProfileHelper

  def find_fave_restaurant(restaurant)
    FavoriteRestaurant.find_by(restaurant_id: restaurant.id, user_id: current_user.id)
  end

end