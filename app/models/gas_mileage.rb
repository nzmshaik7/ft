class GasMileage < ActiveRecord::Base
    #attr_accessible :mdate, :mileage, :vehicle_id
    def gas_mileage_params
	params.require(:gas_mileage).permit(:mdate, :mileage, :vehicle_id)
    end
    belongs_to :vehicle
end
