class StoreToServiceVisit < ActiveRecord::Base
   
    def store_to_service_visit_params
    	params.require(:store_to_service_visit).permit(:id, :name, :number, :manager_id,
			:state_id, :region_id, :county_id, :service_visit_count,
			:total_cost, :store_revenue, :profit_loss)
    end
     belongs_to :county
    belongs_to :region
    belongs_to :state
    belongs_to :manager, class_name: :Employee
end