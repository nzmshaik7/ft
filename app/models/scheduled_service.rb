class ScheduledService < ActiveRecord::Base
    attr_accessible :mileage, :sdate, :service_schedule_id
    belongs_to :service_schedule
    has_many :scheduled_service_items
end
