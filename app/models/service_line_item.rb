class ServiceLineItem < ActiveRecord::Base
    #attr_accessible :labor_hours_actual, :labor_hours_retail,
    #                :labor_rate_actual, :labor_rate_retail,
    #                :service_description_id, :service_description_text,
    #                :service_visit_id, :stype
    def service_line_item_params
	params.require(:service_line_item).permit(:labor_hours_actual, :labor_hours_retail,
                    :labor_rate_actual, :labor_rate_retail,
                    :service_description_id, :service_description_text,
                    :service_visit_id, :stype)
    end
    belongs_to :service_visit
    belongs_to :service_description
    has_many :service_parts
    has_many :technician_hours

    S_QUALIFICATION = 20
    S_MEMB_SERVICE = 21
    S_MEMB_REPAIR = 22
    S_MEMB_NOT_COVERED = 23
    S_NON_MEMB_SERVICE = 24
    S_NON_MEMB_REPAIR = 25
    S_OTHER = 26
    
    def descText
        if service_description_id
            return service_description.name
        else
            return service_description_text
        end
    end


    def stypeText
        return "Qualification"        if stype == S_QUALIFICATION
        return "Membership Service"   if stype == S_MEMB_SERVICE
        return "Membership Repair"    if stype == S_MEMB_REPAIR
        return "Member Not Covered"   if stype == S_MEMB_NOT_COVERED
        return "Non Member Service"   if stype == S_NON_MEMB_SERVICE
        return "Non Member Repair"    if stype == S_NON_MEMB_REPAIR
        return "Other"                if stype == S_OTHER
        return "Unknown"
    end


    def stypeAbbrev
        return "Qual"         if stype == S_QUALIFICATION
        return "Memb Srv"     if stype == S_MEMB_SERVICE
        return "Memb Repr"    if stype == S_MEMB_REPAIR
        return "Not Cvrd"     if stype == S_MEMB_NOT_COVERED
        return "Nonm Srv"     if stype == S_NON_MEMB_SERVICE
        return "Nonm Repr"    if stype == S_NON_MEMB_REPAIR
        return "Other"        if stype == S_OTHER
        return "Unk"
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
