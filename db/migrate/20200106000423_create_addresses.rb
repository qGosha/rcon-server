class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :realtor_profile, foreign_key: true
      t.references :order, foreign_key: true
      t.string :city
      t.string :state
      t.string :zip
      t.string :street

      t.timestamps
    end
  end
end
