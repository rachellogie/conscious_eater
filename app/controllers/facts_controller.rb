class FactsController < ApplicationController

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    @fact = Fact.new(facts_params)
    @fact.restaurant_id = restaurant.id
    @fact.user_id = current_user.id
    @fact.save
    redirect_to restaurant_path(restaurant, :tidbit_edited => "true")
  end

  def destroy
    restaurant = Restaurant.find(params[:restaurant_id])
    Fact.find(params[:id]).destroy
    redirect_to restaurant_path(restaurant, :tidbit_edited => "true")
  end

  private

  def facts_params
    params.require(:fact).permit(:body)
  end
end