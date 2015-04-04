class Payment < ActiveRecord::Base
    attr_accessible :amount, :comment, :contract_id, :customer_id, :date_time, :finance_agreement_id, :invoice_id, :merchant_services_status, :payment_method_id, :status
end
