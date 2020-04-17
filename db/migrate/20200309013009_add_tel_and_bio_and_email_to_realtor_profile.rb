class AddTelAndBioAndEmailToRealtorProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :realtor_profiles, :tel, :string
    add_column :realtor_profiles, :bio, :text
    add_column :realtor_profiles, :email, :string
  end
end
