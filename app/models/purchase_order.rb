class PurchaseOrder < ActiveRecord::Base
    #attr_accessible :date_time, :po_number, :vendor_id
    def purchase_order_params
	params.require(:purchase_order).permit(:date_time, :po_number, :vendor_id)
    end
    belongs_to :vendor
end
