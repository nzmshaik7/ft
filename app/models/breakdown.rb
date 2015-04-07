class Breakdown < ActiveRecord::Base
    attr_accessible :bdate, :description, :vehicle_id
    belongs_to :vehicle
end
