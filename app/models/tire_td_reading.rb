class TireTdReading < ActiveRecord::Base
    attr_accessible :depth32nds, :tdate, :vehicle_id
    belongs_to :vehicle
end
