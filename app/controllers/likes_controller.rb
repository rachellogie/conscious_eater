class LikesController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    fact = Fact.find(params[:fact_id])
    if params[:up]
      fact.liked_by current_user
    elsif params[:down]
      fact.downvote_from current_user
    end
    redirect_to restaurant_path(@restaurant)
  end

end