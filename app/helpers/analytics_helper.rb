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
	    visitLaborRetail += @sliTotLaborRetail
	    visitLaborActual += @sliTotLaborActual
	    visitHoursRetail += @sliTotHoursRetail
	    visitHoursActual += @sliTotHoursActual
            visitPartsRetail += @sliTotPartsRetail
            visitPartsActual += @sliTotPartsActual
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
