class Employee < ActiveRecord::Base
    #attr_accessible :first_name, :last_name, :ssn, :store_id
def employee_params
    params.require(:employee).permit(:first_name, :last_name, :ssn, :store_id)
  end
    belongs_to :store

    def nameText
        return first_name + ' ' + last_name
    end
end
