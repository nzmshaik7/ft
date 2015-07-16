module ServiceLineItemsHelper

    def stypeText(st)
        return "qualification"      if st == ServiceLineItem::S_QUALIFICATION
        return "member service"     if st == ServiceLineItem::S_MEMB_SERVICE
        return "member repair"      if st == ServiceLineItem::S_MEMB_REPAIR
        return "member not covered" if st == ServiceLineItem::S_MEMB_NOT_COVERED
        return "non-member service" if st == ServiceLineItem::S_NON_MEMB_SERVICE
        return "non-member repair"  if st == ServiceLineItem::S_NON_MEMB_REPAIR
        return "other"              if st == ServiceLineItem::S_OTHER
        return "unknown"
    end

    def setTotalsForSvcLineItem(sli)
	@totHoursRetail = 0.0
	@totLaborRetail = 0.0
	@totHoursActual = 0.0
	@totLaborActual = 0.0
        for techhr in sli.technician_hours
	    @totHoursRetail += techhr.labor_hours_retail 
	    @totLaborRetail += 
	                   techhr.labor_hours_retail * techhr.labor_rate_retail
	    @totHoursActual += techhr.labor_hours_actual 
	    @totLaborActual += 
	                   techhr.labor_hours_actual * techhr.labor_rate_actual
	end
    end

end
