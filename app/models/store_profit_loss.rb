class StoreProfitLoss < ActiveRecord::Base
   
    def store_profit_loss_params
    	params.require(:vehicle_profit_loss).permit(:id, :name, :number, :manager_id,
			:state_id, :region_id, :county_id,
			 :store_used_parts_actual_cost, :store_labor_actual_cost, :total_cost, 
			:store_revenue, :profit_loss)
    end
     belongs_to :county
    belongs_to :region
    belongs_to :state
    belongs_to :manager, class_name: :Employee
end