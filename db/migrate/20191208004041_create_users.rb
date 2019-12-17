class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.boolean :is_client
      t.boolean :is_realtor
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
