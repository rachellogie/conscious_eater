class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :website
      t.string :location
      t.string :dietary_options
    end
  end
end
