class RestaurantsController < ApplicationController

  def index
    if params[:search] && params[:option]
      @restaurants = Restaurant.tagged_with(params[:option].keys).where(location: params[:homepage_location])
    elsif params[:search]
      @restaurants = Restaurant.where(location: params[:homepage_location])
    else
      @restaurants = Restaurant.all
    end
  end

  def new
    if user_signed_in?
      @restaurant = Restaurant.new
    else
      render :errors
    end
  end

  def create
    @restaurant = Restaurant.new
    @restaurant.name = params[:restaurant][:name].capitalize
    if params[:option]
      @restaurant.dietary_option_list = params[:option].keys.join(", ")
    end
    @restaurant.location = params[:restaurant][:location]
    @restaurant.website = params[:restaurant][:website]
    @restaurant.address = params[:restaurant][:address]
    initial_time = Time.now
    if @restaurant.save
      end_time = Time.now
      puts "Time elapsed: #{end_time - initial_time}"
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      render new_restaurant_path
    end
  end

  def show
    @favorite_restaurant = FavoriteRestaurant.new
    if Restaurant.exists?(params[:id])
      @restaurant = Restaurant.find(params[:id])
    else
      render :errors
    end
  end

  def edit
    if user_signed_in?
      @restaurant = Restaurant.find(params[:id])
    else
      not_found
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.name = params[:restaurant][:name]
    @restaurant.location = params[:restaurant][:location]
    @restaurant.website = params[:restaurant][:website]
    if params[:option]
      @restaurant.dietary_option_list = params[:option].keys.join(", ")
    else
      @restaurant.dietary_option_list = ''
    end
    if @restaurant.save
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      render :edit
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to "/restaurants"
  end

end