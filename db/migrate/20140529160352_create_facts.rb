class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :body
      t.integer :restaurant_id
      t.index :restaurant_id
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
