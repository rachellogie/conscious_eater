class FavoriteRestaurantsController < ApplicationController

  def create
    FavoriteRestaurant.create(user_id: current_user.id, restaurant_id: params[:restaurant_id])
    flash[:notice]='Restaurant has been favorited!'
    redirect_to restaurant_path(params[:restaurant_id])
  end
end