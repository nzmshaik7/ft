class ManufacturerWarranty < ActiveRecord::Base
    attr_accessible :comment, :image, :miles, :months, :vehicle_id, :wtype
end
