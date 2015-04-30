class ServiceLineItem < ActiveRecord::Base
    attr_accessible :is_scheduled, :labor_hours_actual, :labor_hours_retail,
                    :labor_rate_actual, :labor_rate_retail,
                    :service_description_id, :service_description_text,
                    :service_visit_id, :technician1_id, :technician2_id,
                    :technician3_id
    belongs_to :service_visit
    belongs_to :service_description
    belongs_to :technician1, class_name: :Technician
    belongs_to :technician2, class_name: :Technician
    belongs_to :technician3, class_name: :Technician
    has_many :service_parts
    
    def descText
        if service_description_id
            return service_description.name
        else
            return service_description_text
        end
    end

end
