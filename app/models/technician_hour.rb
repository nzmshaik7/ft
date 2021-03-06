class TechnicianHour < ActiveRecord::Base
    #attr_accessible :labor_hours_actual, :labor_hours_retail, 
    #                :labor_rate_actual, :labor_rate_retail, 
    #		    :service_line_item_id, :technician_id

    def technician_hour_params
	params.require(:technician_hour).permit(:labor_hours_actual, :labor_hours_retail, 
                    :labor_rate_actual, :labor_rate_retail, 
    		    :service_line_item_id, :technician_id)
    end
    belongs_to :service_line_item
    belongs_to :technician
end
