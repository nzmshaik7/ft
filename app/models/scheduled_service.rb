class ScheduledService < ActiveRecord::Base
    #attr_accessible :mileage, :sdate, :service_schedule_id

    def scheduled_service_params
	params.require(:scheduled_service).permit(:mileage, :sdate, :service_schedule_id)
    end
    belongs_to :service_schedule
    has_many :scheduled_service_items

    def serviceText
        return sdate.strftime("%b %d, %Y") + '/' + mileage.to_s + ' mi'
    end

end
