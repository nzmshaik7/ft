class VehicleProfitLoss < ActiveRecord::Base; VehicleProfitLoss < ActiveRecord::Base
   
    def vehicle_profit_loss_params
    	params.require(:vehicle_profit_loss).permit(:vehicle_id, :vin, :contract_id, :make_id, :model_id,
			 :vehicle_parts_actual_cost, :vehicle_labor_actual_cost, :total_cost, 
			:vehicle_revenue, :profit_loss)
    end
    belongs_to :make
    belongs_to :model
    
end
