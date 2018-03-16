class VendorInvoice < ActiveRecord::Base
    #attr_accessible :date_time, :invoice_number, :purchase_order_id, :status, :vendor_id
    def vendor_invoice_params
	params.require(:vendor_invoice).permit(:date_time, :invoice_number, :purchase_order_id, :status, :vendor_id)
    end
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
