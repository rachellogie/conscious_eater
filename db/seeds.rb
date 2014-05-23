# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all

Restaurant.create(name: "Salt", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options" )

Restaurant.create(name: "Shine", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, 100% gluten free, vegan options" )

Restaurant.create(name: "The Kitchen", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, organic ingredients, vegan options" )

Restaurant.create(name: "Leaf", location: "Pearl Street, Boulder",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, 100% vegetarian, organic ingredients" )

Restaurant.create(name: "Linger", location: "Highlands, Denver",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )

Restaurant.create(name: "Root Down", location: "Highlands, Denver",
                  dietary_option_list: "gluten free options, dairy free options, vegetarian options, vegan options, organic ingredients" )







