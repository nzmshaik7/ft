class ScheduledAppointment < ActiveRecord::Base
    attr_accessible :actual_date_time, :date_time, :purpose, :status, 
                    :store_id, :vehicle_id
    belongs_to :vehicle
    belongs_to :store

    STATUS_COMPLETED = 41
    STATUS_PENDING = 42
    STATUS_CANCELLED = 43
    STATUS_MISSED = 44
    
    PURPOSE_SERVICE = 48
    PURPOSE_REPAIR = 49

    def statusText
        return "Completed"    if status == STATUS_COMPLETED
        return "Pending"      if status == STATUS_COMPLETED
        return "Cancelled"    if status == STATUS_CANCELLED
        return "Missed"       if status == STATUS_MISSED
        return "Unknown"
    end

    def purposeText
        return "Service"      if status == PURPOSE_SERVICE
        return "Repair"       if status == PURPOSE_REPAIR
        return "Unknown"
    end

end
