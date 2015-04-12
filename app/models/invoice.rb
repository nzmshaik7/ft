class Invoice < ActiveRecord::Base
    attr_accessible :customer_id, :date_time, :invoice_number, :status
    belongs_to :customer
    has_many   :invoice_line_items

    STATUS_PAID = 71
    STATUS_UNPAID = 72

    def statusText
        return 'paid'   if status == STATUS_PAID
        return 'unpaid' if status == STATUS_UNPAID
        return 'unknown'
    end
end
