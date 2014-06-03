def seed_each_restaurant(restaurant)
  search = PlacesSearch.new(ENV["GOOGLE_API_KEY"], restaurant.name, restaurant.location)
  restaurant.rating = search.get_rating
  restaurant.address = search.get_address
  restaurant.photo_uri = search.get_photo
  restaurant.website = search.get_website
  restaurant.name = search.get_name
  restaurant.save!
end

Restaurant.destroy_all

restaurant = Restaurant.new(name: "Salt", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.create(name: "Shine", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, 100% gluten free, vegan options, grass fed beef, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.create(name: "The Kitchen", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, organic ingredients, vegan options" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.create(name: "Leaf", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, 100% vegetarian, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.create(name: "Linger", location: "Highlands, Denver",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.create(name: "Root Down", location: "Highlands, Denver",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.create(name: "Black Cat", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)

restaurant = Restaurant.create(name: "Mountain Sun", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )
seed_each_restaurant(restaurant)




