class Part < ActiveRecord::Base
    attr_accessible :actual_cost, :description, :part_manufacturer_id, :part_name_id, :part_number, :retail_price
end
