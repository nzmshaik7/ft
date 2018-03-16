class EnrollmentPlan < ActiveRecord::Base
    #attr_accessible :name
 def enrollment_plan_params
      params.require(:enrollment_plan).permit(:name)
    end

    
end
