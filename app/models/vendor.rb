class Vendor < ActiveRecord::Base
    #attr_accessible :name
    def vendor_params
	params.require(:vendor).permit(:name)
   end
end
