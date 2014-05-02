# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all

Restaurant.create(name: "Salt", location: "Pearl Street, Boulder", website: "Salt.com",
                  dietary_option_list: "gluten free, dairy free" )

Restaurant.create(name: "Shine", location: "Pearl Street, Boulder", website: "shine.com",
                  dietary_option_list: "gluten free, dairy free" )



Restaurant.create(name: "Linger", location: "Highlands, Denver", website: "linger.com",
                  dietary_option_list: "gluten free, dairy free" )

Restaurant.create(name: "Root Down", location: "Highlands, Denver", website: "rootdown.com",
                  dietary_option_list: "gluten free, dairy free" )







