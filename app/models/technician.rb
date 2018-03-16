class Technician < ActiveRecord::Base
    #attr_accessible :employee_id, :hourly_rate, :level
    def technician_params
   	 params.require(:technician).permit(:employee_id, :hourly_rate, :level)
    end
    belongs_to :employee
end
