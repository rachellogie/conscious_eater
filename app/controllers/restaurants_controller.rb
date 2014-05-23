class RestaurantsController < ApplicationController

  def index
    if params[:search] && params[:option]
      if params[:save]
        Preference.where(user_id: current_user.id).destroy_all if !Preference.find_by(user_id: current_user.id).nil?
        params[:option].each do |preference|
          Preference.create(preference_name: preference.first, user_id: current_user.id)
        end
      end
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
    @restaurant = Restaurant.new(allowed_parameters)
    @restaurant.name = params[:restaurant][:name].titleize
    if params[:option]
      @restaurant.dietary_option_list = params[:option].keys.join(", ")
    end
    initial_time = Time.now
    if @restaurant.save
      end_time = Time.now
      puts "Time elapsed: #{end_time - initial_time}"
      redirect_to restaurant_path(@restaurant)
    else
      render new_restaurant_path
    end
  end

  def show
    @favorite_restaurant = FavoriteRestaurant.new
    if Restaurant.exists?(params[:id])
      @restaurant = Restaurant.find(params[:id])
    else
      render 'errors/404', status: 404
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
    @restaurant.update_attributes(allowed_parameters)
    @restaurant.name = params[:restaurant][:name].capitalize
    if params[:option]
      @restaurant.dietary_option_list = params[:option].keys.join(", ")
    else
      @restaurant.dietary_option_list = ''
    end
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to restaurants_path
  end

  def allowed_parameters
    params.require(:restaurant).permit(:address, :location, :website)
  end

end