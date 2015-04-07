class InvoiceLineItem < ActiveRecord::Base
    attr_accessible :amount, :description, :invoice_id, :line_item_purpose_id,
                    :service_visit_id, :vehicle_id
    belongs_to :invoice
    belongs_to :line_item_purpose
    belongs_to :service_visit
    belongs_to :vehicle
    belongs_to :line_item_purpose
end
