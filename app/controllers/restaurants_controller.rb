class RestaurantsController < ApplicationController

  def search
    @restaurants = Restaurant.search(params[:homepage_location], params.fetch(:option, {}).keys)
    Preference.save_preferences_for(current_user, params[:option]) if params[:save]
    if params[:surprise]
      @restaurant = @restaurants.sample
      redirect_to restaurant_path(@restaurant)
    else
      @latitude, @longitude = APIRequest.new.get_lat_lng(params[:homepage_location])
      render :search_results
    end
  end

  def new
    if user_signed_in?
      @restaurant = Restaurant.new
    else
      render :errors
    end
  end

  def show
    @favorite_restaurant = FavoriteRestaurant.new
    if Restaurant.exists?(params[:id])
      @restaurant = Restaurant.find(params[:id])
      @fact = Fact.new
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

  def create
    @restaurant = Restaurant.new(restaurant_attributes)
    if @restaurant.name?
      api_response = APIRequest.new.get_first_result(@restaurant.name, @restaurant.location)
      search_attributes = api_response.to_h
      @restaurant.attributes = search_attributes
    end

    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_attributes)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def restaurant_attributes
    attributes = params.require(:restaurant).permit(:address, :location, :website, :name)
    attributes[:name] = attributes[:name].titleize
    attributes[:dietary_option_list] = params.fetch(:option, {}).keys.join(", ")
    attributes
  end

end