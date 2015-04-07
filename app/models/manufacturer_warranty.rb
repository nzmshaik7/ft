class ManufacturerWarranty < ActiveRecord::Base
    attr_accessible :comment, :image, :miles, :months, :vehicle_id, :wtype
    belongs_to :vehicle
    belongs_to :image, class_name: :Image

    WTYPE_BUMPER = 21
    WTYPE_POWERTRAIN = 22
    WTYPE_TRANSMISSION = 23
    WTYPE_OTHER = 24

    def wtypeText
        return "Bumper-to-bumper"  if wtype == 21
        return "Powertrain"        if wtype == 22
        return "Transmission"      if wtype == 23
        return "Other"             if wtype == 24
        return "Unknown"
    end

end
