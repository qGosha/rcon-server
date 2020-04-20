class CreateRespondedOrSentOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :responded_or_sent_orders do |t|
      t.integer :order_id
      t.integer :realtor_id

      t.timestamps
    end
    add_index :responded_or_sent_orders, :order_id
    add_index :responded_or_sent_orders, :realtor_id
    add_index :responded_or_sent_orders, [:order_id, :realtor_id], unique: true
  end
end
