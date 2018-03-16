class ManufacturerWarrantyType < ActiveRecord::Base
    #attr_accessible :name
    def manufacturer_warranty_type_params
	params.require(:manufacturer_warranty_type).permit(:name)
    end
end
