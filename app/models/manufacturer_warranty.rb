class ManufacturerWarranty < ActiveRecord::Base
    #attr_accessible :comment, :image_id, :miles, :months, :vehicle_id, :manufacturer_warranty_type_id
    def manufacture_warranty_params
	params.require(:manufacture_warranty).permit(:comment, :image_id, :miles, :months, :vehicle_id, :manufacturer_warranty_type_id)
    end
    belongs_to :vehicle
    belongs_to :image, class_name: :Image
    belongs_to :manufacturer_warranty_type

end
