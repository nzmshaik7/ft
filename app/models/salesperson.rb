class Salesperson < ActiveRecord::Base
    #attr_accessible :employee_id
def salesperson_params
    params.require(:salesperson).permit(:employee_id)
  end
    belongs_to :employee
end
