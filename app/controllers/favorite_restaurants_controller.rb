class FavoriteRestaurantsController < ApplicationController

  def create
    if !FavoriteRestaurant.exists?(user_id: current_user.id, restaurant_id: params[:restaurant_id])
      FavoriteRestaurant.create(user_id: current_user.id, restaurant_id: params[:restaurant_id])
      flash[:notice]='Restaurant has been favorited!'
    else
      flash[:notice]='You already have this as a favorite!'
    end
    redirect_to restaurant_path(params[:restaurant_id])
  end
end