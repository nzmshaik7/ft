class GasMileage < ActiveRecord::Base
    attr_accessible :mdate, :mileage, :vehicle_id
    belongs_to :vehicle
end
