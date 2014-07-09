class FavoriteRestaurantsController < ApplicationController

  def create
    if FavoriteRestaurant.exists?(user_id: current_user.id, restaurant_id: params[:restaurant_id])
      flash[:notice]='You already have this as a favorite!'
    else
      FavoriteRestaurant.create(user_id: current_user.id, restaurant_id: params[:restaurant_id])
      flash[:notice]='Restaurant has been favorited!'
    end
    redirect_to restaurant_path(params[:restaurant_id])
  end

  def destroy
    FavoriteRestaurant.find(params[:id]).destroy
    redirect_to profile_path
  end

end