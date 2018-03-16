class ScheduledServiceItem < ActiveRecord::Base
    #attr_accessible :other, :scheduled_service_id, :service_description_id
    def scheduled_service_item_params
	params.require(:scheduled_service_item).permit(:other, :scheduled_service_id, :service_description_id)
    end
    belongs_to :scheduled_service
    belongs_to :service_description
end
