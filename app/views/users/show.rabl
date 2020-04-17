object @user

attributes :id, :email, :role, :first_name, :last_name

child(:realtor_profile, :if => lambda { |u| u.role == 'realtor' }) do |u|
    extends("realtor_profiles/show")
    # child(:address) { extends("addresses/show") }
  end