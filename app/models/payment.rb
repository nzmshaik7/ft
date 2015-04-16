class Payment < ActiveRecord::Base
    attr_accessible :amount, :comment, :contract_id, :customer_id,
                    :date_time, :finance_agreement_id, :invoice_id,
                    :merchant_services_status, :payment_method_id, :status

    belongs_to :invoice
    belongs_to :contract
    belongs_to :finance_agreement
    belongs_to :customer
    belongs_to :payment_method

    STATUS_APPOVED = 31
    STATUS_DENIED = 32
    STATUS_PENDING = 33

    def statusText
        return "Approved"  if status == 31
        return "Denied"    if status == 32
        return "Pending"   if status == 33
        return "Unknown"
    end

end
