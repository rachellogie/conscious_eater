def seed_each_restaurant(restaurant)
  api_hash = APIRequest.new.get_first_result(restaurant.name, restaurant.location)
  search = ApiResponse.new(api_hash)
  restaurant.attributes = search.to_h
  restaurant.save!
end

Restaurant.destroy_all

restaurant = Restaurant.new(name: "Salt", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.new(name: "Shine", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, 100% gluten free, vegan options, grass fed beef, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.new(name: "The Kitchen", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, organic ingredients, vegan options" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.new(name: "Leaf", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, 100% vegetarian, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.new(name: "Linger", location: "Highlands, Denver",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.new(name: "Root Down", location: "Highlands, Denver",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.new(name: "Black Cat", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.new(name: "Mountain Sun", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)




