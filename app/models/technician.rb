class Technician < ActiveRecord::Base
    attr_accessible :employee_id, :hourly_rate, :level
    belongs_to :employee
end
