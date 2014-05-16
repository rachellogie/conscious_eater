class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string :preference_name
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
