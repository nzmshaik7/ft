class StoreTechnicianDetails < ActiveRecord::Base
   
    def store_technician_details_params
    	params.require(:store_technician_Details).permit(:store_id, :technician_id, :employee_id, 
			:billed_hours, :retail_hours, :actual_hours, 
			:billed_rate, :retail_rate, :actual_rate,
			:efficiency, :productivity, :proficiency)
    end
    belongs_to :technician, class_name: :Employee
    belongs_to :manager, class_name: :Employee
end