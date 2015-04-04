class InvoiceLineItem < ActiveRecord::Base
    attr_accessible :amount, :description, :invoice_id, :line_item_purpose_id, :service_visit_id, :vehicle_id
end
