class AddTimestampsToRestaurants < ActiveRecord::Migration
  def change
    change_table :restaurants do |t|
      t.timestamps
    end
  end
end
