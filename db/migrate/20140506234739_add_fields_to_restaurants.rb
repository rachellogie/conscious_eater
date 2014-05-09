class AddFieldsToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :address, :string
    add_column :restaurants, :photo_uri, :string
    add_column :restaurants, :rating, :string
  end
end
