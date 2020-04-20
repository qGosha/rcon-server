class RespondedOrSentOrder < ApplicationRecord
    validates :order_id, presence: true
    validates :realtor_id, presence: true

    scope :by_order_id, lambda {|*ids| where(:order_id => ids.flatten.uniq.compact) }
    scope :by_realtor_id, lambda {|*ids| where(:realtor_id => ids.flatten.uniq.compact) }
end
