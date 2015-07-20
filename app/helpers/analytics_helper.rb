module AnalyticsHelper

    # Just get the total actual and retail labor cost and parts costs
    # for one service visit.
    # 
    def getSumsForSvcVisit(sv)
	ans = Hash.new
	visitLaborRetail = 0.0
	visitLaborActual = 0.0
	visitHoursRetail = 0.0
	visitHoursActual = 0.0
	visitPartsRetail = 0.0
	visitPartsActual = 0.0
	hasScheduled = false
	for sli in sv.service_line_items
	    setTotalsForSvcLineItem(sli)
	    visitLaborRetail += @totLaborRetail
	    visitLaborActual += @totLaborActual
	    visitHoursRetail += @totHoursRetail
	    visitHoursActual += @totHoursActual
	    for servicePart in sli.service_parts
		visitPartsRetail += servicePart.part_retail_price
		visitPartsActual += servicePart.part_actual_price
	    end
	    hasScheduled = true  if sli.is_scheduled
	end
	ans[:laborRetail] = visitLaborRetail
	ans[:laborActual] = visitLaborActual
	ans[:hoursRetail] = visitHoursRetail
	ans[:hoursActual] = visitHoursActual
	ans[:partsRetail] = visitPartsRetail
	ans[:partsActual] = visitPartsActual
	ans[:hasScheduled] = hasScheduled
	return ans
    end

end
