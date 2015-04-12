class ManufacturerWarranty < ActiveRecord::Base
    attr_accessible :comment, :image, :miles, :months, :vehicle_id, 
                    :manufacturer_warranty_type_id
    belongs_to :vehicle
    belongs_to :image, class_name: :Image

end
