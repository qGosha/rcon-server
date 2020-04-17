class AddRealtorProfileToAddress < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :realtor_profile, foreign_key: true
  end
end
