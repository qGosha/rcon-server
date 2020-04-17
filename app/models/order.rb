class Order < ApplicationRecord
    has_one :address, dependent: :destroy
    belongs_to :user
    accepts_nested_attributes_for :address
    enum role: [:buy, :sell]
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
    format: { with: VALID_EMAIL_REGEX } 
end
