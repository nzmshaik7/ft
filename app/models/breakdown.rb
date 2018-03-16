class Breakdown < ActiveRecord::Base
    #attr_accessible :bdate, :description, :vehicle_id
    def breakdown_params
	params.require(:breakdown).permit(:bdate, :description, :vehicle_id)
    end
    belongs_to :vehicle
end
