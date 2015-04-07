class Salesperson < ActiveRecord::Base
    attr_accessible :employee_id
    belongs_to :employee
end
