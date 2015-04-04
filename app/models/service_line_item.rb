class ServiceLineItem < ActiveRecord::Base
    attr_accessible :is_scheduled, :labor_hours_actual, :labor_hours_retail, :labor_rate_actual, :labor_rate_retail, :service_description_id, :service_description_text, :service_visit_id, :technician1_id, :technician2_id, :technician3_id
end
