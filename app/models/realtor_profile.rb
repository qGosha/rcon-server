class RealtorProfile < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
  format: { with: VALID_EMAIL_REGEX } 
end
