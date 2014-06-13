class RestaurantsController < ApplicationController

  def index
    if params[:search] && params[:option]
      if params[:save]
        populate_preferences(params[:option])
      end
      @restaurants = Restaurant.tagged_with(params[:option].keys).where(location: params[:homepage_location])
    elsif params[:search]
      @restaurants = Restaurant.where(location: params[:homepage_location])
    else
      @restaurants = Restaurant.all
    end

    #use params[:homepage_location] to get the lat and long of the map?
    #@latitude =
    #@longitude =

    if params[:surprise]
      @surprise = @restaurants.sample
      render 'welcome/index'
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
    @restaurant = Restaurant.new
    populate_restaurant_from_params(@restaurant, allowed_parameters)

    if @restaurant.name?
      search = PlacesSearch.new(ENV["GOOGLE_API_KEY"], @restaurant.name, @restaurant.location)
      populate_restaurant(search, @restaurant)
    end

    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    populate_restaurant_from_params(@restaurant, allowed_parameters)

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

  private

  def populate_preferences(options)
    Preference.where(user_id: current_user.id).destroy_all if !Preference.find_by(user_id: current_user.id).nil?
    options.each do |preference|
      Preference.create(preference_name: preference.first, user_id: current_user.id)
    end
  end

  def populate_restaurant_from_params(restaurant, attributes)
    restaurant.attributes = attributes
    restaurant.name = restaurant.name.titleize
    if params[:option]
      restaurant.dietary_option_list = params[:option].keys.join(", ")
    else
      restaurant.dietary_option_list = ''
    end
  end

  def populate_restaurant(search, restaurant)
    if search.matches?
      restaurant.rating = search.get_rating
      restaurant.address = search.get_address
      restaurant.photo_uri = search.get_photo
      restaurant.website = search.get_website
      restaurant.name = search.get_name
    end
  end

  def allowed_parameters
    params.require(:restaurant).permit(:address, :location, :website, :name)
  end

end