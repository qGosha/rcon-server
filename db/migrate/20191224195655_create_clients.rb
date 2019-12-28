class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
