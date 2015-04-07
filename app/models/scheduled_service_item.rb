class ScheduledServiceItem < ActiveRecord::Base
    attr_accessible :other, :scheduled_service_id, :service_description_id
    belongs_to :scheduled_service
    belongs_to :service_description
end
