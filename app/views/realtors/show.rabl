require 'rabl_helper'

object @realtor

attributes :id, :first_name, :last_name
node(:rating) do |realtor|
    ratings = realtor.received_rating
    size = ratings.size == 0 ? 1 : ratings.size
    (ratings.map(&:value).inject{ |sum, el| sum + el }.to_f / size).round
end

node(:raters_total) { |realtor| realtor.received_rating.size }
node(:city) { |realtor| realtor.realtor_profile && realtor.realtor_profile.address.city }
node(:state) { |realtor| realtor.realtor_profile && realtor.realtor_profile.address.state }
node(:avatar) { |realtor| generate_url(realtor.realtor_profile.avatar) if realtor.realtor_profile && realtor.realtor_profile.avatar.attached? }
