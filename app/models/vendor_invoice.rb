class VendorInvoice < ActiveRecord::Base
    attr_accessible :date_time, :invoice_number, :purchase_order_id, :status,
                    :vendor_id
    belongs_to :vendor
    belongs_to :purchase_order

    STATUS_PAID = 71
    STATUS_UNPAID = 72

    def statusText
        return 'paid'   if status == STATUS_PAID
        return 'unpaid' if status == STATUS_UNPAID
        return 'unknown'
    end
end
