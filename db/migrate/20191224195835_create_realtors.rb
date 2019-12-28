class CreateRealtors < ActiveRecord::Migration[5.2]
  def change
    create_table :realtors do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.text :bio

      t.timestamps
    end
  end
end
