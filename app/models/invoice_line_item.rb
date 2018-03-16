class InvoiceLineItem < ActiveRecord::Base
    #attr_accessible :amount, :description, :invoice_id, :line_item_purpose_id, :service_visit_id, :vehicle_id
    def invoice_line_item_params
	params.require(invoice_line_item).permit(:amount, :description, :invoice_id, :line_item_purpose_id, :service_visit_id, :vehicle_id)
    end
    belongs_to :invoice
    belongs_to :line_item_purpose
    belongs_to :service_visit
    belongs_to :vehicle
    belongs_to :line_item_purpose
end
