class ServiceSchedule < ActiveRecord::Base
    #attr_accessible :image_id
    def service_schedule_params
	params.require(:service_schedule).permit(:image_id)
    end
    belongs_to :image
    has_many :scheduled_services
end
