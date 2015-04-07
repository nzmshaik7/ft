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
        return "Completed"    if status == 41
        return "Pending"      if status == 42
        return "Cancelled"    if status == 43
        return "Missed"       if status == 44
        return "Unknown"
    end

    def purposeText
        return "Service"      if status == 48
        return "Repair"       if status == 49
        return "Unknown"
    end

end
