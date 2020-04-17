class CreateRealtorRespondedOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :realtor_responded_orders do |t|
      t.integer :order_id
      t.integer :realtor_id

      t.timestamps
    end
    add_index :realtor_responded_orders, :order_id
    add_index :realtor_responded_orders, :realtor_id
    add_index :realtor_responded_orders, [:order_id, :realtor_id], unique: true
  end
end
