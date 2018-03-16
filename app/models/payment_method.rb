class PaymentMethod < ActiveRecord::Base
    #attr_accessible :account_number_id, :customer_id, :expiration_month,
    #                :expiration_year, :image_id, :payment_type_id, :priority, 
    #                :routing_number
    def payment_method_params
	params.require(:payment_method).permit(:account_number_id, :customer_id, :expiration_month,
                    :expiration_year, :image_id, :payment_type_id, :priority, 
                    :routing_number)
    end
    belongs_to :customer
    belongs_to :payment_type
    # belongs_to :image  Off-server
end
