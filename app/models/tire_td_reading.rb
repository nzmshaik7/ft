class TireTdReading < ActiveRecord::Base
    #attr_accessible :depth32nds, :tdate, :vehicle_id
    def tire_td_reading_params
	params.require(:tire_td_reading).permit(:depth32nds, :tdate, :vehicle_id)
    end
    belongs_to :vehicle
end
