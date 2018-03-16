class PaymentType < ActiveRecord::Base
    #attr_accessible :name
    def payment_type_params
	params.require(:payment_type).permit(:name)
    end
end
