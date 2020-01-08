class Address < ApplicationRecord
  validates :city,  presence: true, length: { maximum: 50 }
  validates :state,  presence: true, length: { maximum: 10 }

  belongs_to :order
end
