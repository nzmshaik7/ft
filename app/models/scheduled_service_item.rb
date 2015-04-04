class ScheduledServiceItem < ActiveRecord::Base
    attr_accessible :other, :scheduled_service_id, :service_description_id
end
