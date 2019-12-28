class Realtor < ApplicationRecord
  belongs_to :user
  validates :first_name, presence: true, length: { maximum: 255 } 
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :bio, presence: true
end
