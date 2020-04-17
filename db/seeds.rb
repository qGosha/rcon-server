# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

30.times do |i|
    role = (0..1).to_a.sample
    email = "#{role == 0 ? "realtor" : "client"}-#{i+1}@qwerty.com"
    password = "password"
    user = User.create!({
        email: email,
        password: password,
        password_confirmation: password,
        role: role,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
    })
end

@clients = User.where(role: 1)
@realtors = User.where(role: 0)

@realtors.each do |realtor|
    profile = realtor.create_realtor_profile!({
        bio: Faker::Lorem.paragraph,
        tel: Faker::PhoneNumber.cell_phone,
        email: realtor.email,
    })
    profile.create_address!({
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip: Faker::Address.zip,
    })
end

@clients.each do |client|
    2.times do |i|
        order = client.orders.create!({
            order_type: (0..1).to_a.sample,
            description: Faker::Lorem.paragraph,
            email: client.email,
            tel: Faker::PhoneNumber.cell_phone,
        })
        order.create_address!({
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zip: Faker::Address.zip,
        })
    end 
end


300.times do |i|
    RealtorRating.create!({
        value: (1..5).to_a.sample,
        client_id: @clients[(0..@clients.size - 1).to_a.sample].id,
        realtor_id: @realtors[(0..@realtors.size - 1).to_a.sample].id,
    })
    end
