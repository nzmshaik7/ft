class ServiceVisit < ActiveRecord::Base
    attr_accessible :comments, :description, :invoice_id, :mileage,
                    :salesperson_id, :sdate, :store_id, :vehicle_id
    belongs_to :vehicle
    belongs_to :invoice
    belongs_to :salesperson
    belongs_to :store
    has_many :service_line_items
    has_many :service_journals
end
