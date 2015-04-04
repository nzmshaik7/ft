class Invoice < ActiveRecord::Base
    attr_accessible :customer_id, :date_time, :invoice_number, :status
end
