module AnalyticsHelper

    # Just get the total actual and retail labor cost for one service visit.
    # 
    def getLaborForSvcVisit(sv)
	ans = Hash.new
	visitLaborRetail = 0.0
	visitLaborActual = 0.0
	for sli in sv.service_line_items
	    setTotalsForSvcLineItem(sli)
	    visitLaborRetail += @totLaborRetail
	    visitLaborActual += @totLaborActual
	end
	ans[:retail] = visitLaborRetail
	ans[:actual] = visitLaborActual
	return ans
    end

end
