class RestaurantsController < ApplicationController

  def index
    if params[:search]
      @restaurants = Restaurant.where(location: params[:homepage_location])
      return @restaurants
    else
      @restaurants = Restaurant.all
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new
    @restaurant.name = params[:restaurant][:name]
    @restaurant.location = params[:restaurant][:location]
    @restaurant.website = params[:restaurant][:website]
    @restaurant.gluten_free_options = params[:restaurant][:gluten_free_options]
    @restaurant.dairy_free_options = params[:restaurant][:dairy_free_options]
    @restaurant.save
    redirect_to "/restaurants/#{@restaurant.id}"
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.name = params[:restaurant][:name]
    @restaurant.location = params[:restaurant][:location]
    @restaurant.website = params[:restaurant][:website]
    @restaurant.gluten_free_options = params[:restaurant][:gluten_free_options]
    @restaurant.dairy_free_options = params[:restaurant][:dairy_free_options]
    @restaurant.save
    redirect_to "/restaurants/#{@restaurant.id}"
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to "/restaurants"
  end

end