class VehicleToServiceVisit < ActiveRecord::Base
   
    def vehicle_profit_loss_params
    	params.require(:vehicle_to_service_visit).permit(:id, :vin, :make_id, :model_id,
			:date_of_manufacture, :service_visit_count, :total_cost, :vehicle_revenue, :profit_loss)
    end
    belongs_to :make
    belongs_to :model
    
end
