class InsuranceCompany < ActiveRecord::Base
    #attr_accessible :name
 def insurance_company_params
      params.require(:insurance_company).permit(:name)
    end
end
