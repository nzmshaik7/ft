class ServiceCategory < ActiveRecord::Base
    #attr_accessible :name
    def service_category_params
       params.require(:service_category).permit(:name)
    end

end
