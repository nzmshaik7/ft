class FinanceAgreement < ActiveRecord::Base
    #attr_accessible :agreement_image_id, :customer_id, :end_date,
    #                :finance_fee, :missed_payment_fee,
    #                :monthly_payment_amount, :start_date, :title_image_id,
    #                :total_principal

    def finance_agreement_params
	params.require(:finance_agreement).permit(:agreement_image_id, :customer_id, :end_date,
                    :finance_fee, :missed_payment_fee,
                    :monthly_payment_amount, :start_date, :title_image_id,
                    :total_principal)
    end
    belongs_to :agreement_image, class_name: :Image
    belongs_to :customer
    belongs_to :title_image
    has_many   :payments
end
