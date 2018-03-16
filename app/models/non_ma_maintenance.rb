class NonMaMaintenance < ActiveRecord::Base
    #attr_accessible :document_image_id, :mdate, :vehicle_id, :where
    def non_ma_maintenance_params
	params.require(:non_ma_maintenance).permit(:document_image_id, :mdate, :vehicle_id, :where)
    end
    belongs_to :vehicle
    belongs_to :document_image, class_name: :Image
end
