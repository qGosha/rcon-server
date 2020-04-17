class CreateRealtorRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :realtor_ratings do |t|
      t.integer :value
      t.integer :client_id
      t.integer :realtor_id

      t.timestamps
    end
    add_index :realtor_ratings, :client_id
    add_index :realtor_ratings, :realtor_id
    add_index :realtor_ratings, [:client_id, :realtor_id], unique: true
  end
end
