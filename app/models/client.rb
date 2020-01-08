class Client < ApplicationRecord
  belongs_to :user
  has_many :orders
  validates :first_name, presence: true, length: { maximum: 255 }
end
