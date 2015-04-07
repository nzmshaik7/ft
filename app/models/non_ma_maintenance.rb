class NonMaMaintenance < ActiveRecord::Base
    attr_accessible :document_image_id, :mdate, :vehicle_id, :where
    belongs_to :vehicle
    belongs_to :document_image, class_name: :Image
end
