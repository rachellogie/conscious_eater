class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :location
      t.string :website
      t.boolean :gluten_free_options, default: false
      t.boolean :dairy_free_options, default: false
      t.timestamps
    end
  end
end
