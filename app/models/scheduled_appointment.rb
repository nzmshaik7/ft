class ScheduledAppointment < ActiveRecord::Base
    attr_accessible :actual_date_time, :date_time, :purpose, :status, :store_id, :vehicle_id
end
