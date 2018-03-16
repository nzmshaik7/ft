class UsedPart < ActiveRecord::Base
   
    def used_part_params
    	params.require(:used_part).permit( :store_id, :vehicle_id, :part_manufacturer_id, :part_name_id, :quantity)
    end
    belongs_to :part_name
    belongs_to :part_manufacturer
    belongs_to :store
    belongs_to :vehicle
end
