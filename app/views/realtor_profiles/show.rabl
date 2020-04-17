require 'rabl_helper'

object @realtor_profile

attributes :id, :tel, :bio, :email
node(:avatar) { |realtor_profile| generate_url(realtor_profile.avatar) if realtor_profile.avatar.attached? }
child(:address) { extends("addresses/show") }
