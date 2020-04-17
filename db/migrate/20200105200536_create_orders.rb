class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :order_type
      t.text :description
      t.string :email
      t.string :tel

      t.timestamps
    end
  end
end
