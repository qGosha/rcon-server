class RealtorRating < ApplicationRecord
    belongs_to :user, optional: true
    validates :client_id, presence: true
    validates :realtor_id, presence: true
    validates :value, presence: true
end
