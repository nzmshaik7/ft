class Invoice < ActiveRecord::Base
    attr_accessible :customer_id, :date_time, :invoice_number, :status
    belongs_to :customer
    has_many   :invoice_line_items
end
