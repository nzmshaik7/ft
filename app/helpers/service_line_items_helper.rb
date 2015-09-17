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
	@sliTotHoursRetail = 0.0
	@sliTotLaborRetail = 0.0
	@sliTotHoursActual = 0.0
	@sliTotLaborActual = 0.0
	@sliTotPartsRetail = 0.0
	@sliTotPartsActual = 0.0
        for techhr in sli.technician_hours
	    @sliTotHoursRetail += techhr.labor_hours_retail 
	    @sliTotLaborRetail += 
	                   techhr.labor_hours_retail * techhr.labor_rate_retail
	    @sliTotHoursActual += techhr.labor_hours_actual 
	    @sliTotLaborActual += 
	                   techhr.labor_hours_actual * techhr.labor_rate_actual
	end
        for sp in sli.service_parts
            @sliTotPartsRetail += sp.quantity * sp.part_retail_price
            @sliTotPartsActual += sp.quantity * sp.part_actual_price
        end
        @sliTotProfit = (@sliTotLaborRetail + @sliTotPartsRetail) -
                        (@sliTotLaborActual + @sliTotPartsActual)
    end

end
