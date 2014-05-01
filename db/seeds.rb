# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all

Restaurant.create(name: "Salt", location: "Pearl Street, Boulder", website: "Salt.com",
                  gluten_free_options: true, dairy_free_options: true)

Restaurant.create(name: "Shine", location: "Pearl Street, Boulder", website: "shine.com",
                  gluten_free_options: true, dairy_free_options: true)



Restaurant.create(name: "Linger", location: "Highlands, Denver", website: "linger.com",
                  gluten_free_options: true, dairy_free_options: true)

Restaurant.create(name: "Root Down", location: "Highlands, Denver", website: "rootdown.com",
                  gluten_free_options: true, dairy_free_options: true)







