class ManufacturerWarranty < ActiveRecord::Base
    attr_accessible :comment, :image_id, :miles, :months, :vehicle_id, 
                    :manufacturer_warranty_type_id
    belongs_to :vehicle
    belongs_to :image, class_name: :Image
    belongs_to :manufacturer_warranty_type

end
