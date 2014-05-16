class CreateFavoriteRestaurantsJoinTable < ActiveRecord::Migration
  def change
    create_table :favorite_restaurants do |t|
      t.integer :user_id
      t.index :user_id
      t.integer :restaurant_id
      t.index :restaurant_id
    end
  end
end
