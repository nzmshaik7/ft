class FinanceAgreement < ActiveRecord::Base
    attr_accessible :agreement_image_id, :customer_id, :end_date, :finance_fee, :missed_payment_fee, :monthly_payment_amount, :start_date, :title_image_id, :total_principal
end
