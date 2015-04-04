class PaymentMethod < ActiveRecord::Base
    attr_accessible :account_number_id, :customer_id, :expiration_month, :expiration_year, :image_id, :paytype, :priority, :routing_number
end
