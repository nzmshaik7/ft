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
    STATUS_REFERRAL = 34
    STATUS_UP_APPOVED = 35
    STATUS_UP_DENIED = 36
    STATUS_UP_PENDING = 37
    STATUS_LAST = 37

    STATUS_OPTIONS = [  # Suitable for select dropdown helper
            [ "Select",   0  ],
            [ "Approved",          STATUS_APPOVED ],
            [ "Denied",            STATUS_DENIED ],
            [ "Pending",           STATUS_PENDING ],
            [ "Referral",          STATUS_REFERRAL ],
            [ "Approved Upgrade",  STATUS_UP_APPOVED ],
            [ "Denied Upgrade",    STATUS_UP_DENIED ],
            [ "Pending Upgrade",   STATUS_UP_PENDING ],
    ]

    def statusText
        return "Approved"    if status == 31
        return "Denied"      if status == 32
        return "Pending"     if status == 33
        return "Referral"    if status == 34
        return "Approved"    if status == 35
        return "Denied upg"  if status == 36
        return "Pending upg" if status == 37
        return "Unknown"
    end

    def statusValid?
        return false  if status.nil?
        return false  if status < STATUS_APPOVED 
        return false  if status > STATUS_LAST
        return true
    end

    def statusCompleted?
        if status == STATUS_APPOVED or status == STATUS_REFERRAL or
                                       status == STATUS_UP_APPOVED
            return true
        end
        return false
    end

end
