class ServicePart < ActiveRecord::Base
    attr_accessible :part_actual_price, :part_id, :part_retail_price,
                    :service_line_item_id
    belongs_to :service_line_item
    belongs_to :part
end
