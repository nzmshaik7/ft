class PurchaseOrder < ActiveRecord::Base
    attr_accessible :date_time, :po_number, :vendor_id
    belongs_to :vendor
end
