class ServiceVisit < ActiveRecord::Base
    attr_accessible :comments, :description, :invoice_id, :mileage, :salesperson_id, :sdate, :store_id, :vehicle_id
end
