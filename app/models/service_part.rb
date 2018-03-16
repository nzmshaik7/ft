class ServicePart < ActiveRecord::Base
    #attr_accessible :part_actual_price, :part_id, :part_retail_price,
    #                :service_line_item_id, :quantity
    def sevice_part_params
	params.require(:service_part).permit(:part_actual_price, :part_id, :part_retail_price,
                    :service_line_item_id, :quantity)
    end
    belongs_to :service_line_item
    belongs_to :part
end
