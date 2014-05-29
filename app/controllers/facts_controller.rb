class FactsController < ApplicationController

  def create
    restaurant = Restaurant.find(params[:restaurant_id])

    @fact = Fact.create(facts_params)
    @fact.restaurant_id = restaurant.id
    @fact.user_id = current_user.id
    @fact.save
    redirect_to restaurant_path(restaurant)
  end

  private

  def facts_params
    params.require(:fact).permit(:body)
  end
end