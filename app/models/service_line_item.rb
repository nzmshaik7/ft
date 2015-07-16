class ServiceLineItem < ActiveRecord::Base
    attr_accessible :labor_hours_actual, :labor_hours_retail,
                    :labor_rate_actual, :labor_rate_retail,
                    :service_description_id, :service_description_text,
                    :service_visit_id, :stype
    belongs_to :service_visit
    belongs_to :service_description
    has_many :service_parts
    has_many :technician_hours

    S_QUALIFICATION = 81
    S_MEMB_SERVICE = 82
    S_MEMB_REPAIR = 83
    S_MEMB_NOT_COVERED = 84
    S_NON_MEMB_SERVICE = 85
    S_NON_MEMB_REPAIR = 86
    S_OTHER = 87
    
    def descText
        if service_description_id
            return service_description.name
        else
            return service_description_text
        end
    end

    def is_scheduled
        return true  if stype == S_MEMB_SERVICE
        return false
    end

    def stypeIsValid(st = nil)
        if st.nil?
            st = stype
        end
        if st.nil?
            return false
        end
        if st >= S_QUALIFICATION and st <= S_OTHER
            return true
        end
        return false
    end

end
