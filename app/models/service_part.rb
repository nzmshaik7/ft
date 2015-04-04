class ServicePart < ActiveRecord::Base
    attr_accessible :part_actual_price, :part_id, :part_retail_price, :service_line_item_id
end
