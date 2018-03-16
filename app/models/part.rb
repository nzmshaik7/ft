class Part < ActiveRecord::Base
    #attr_accessible :description, :part_manufacturer_id,
    #                :part_name_id, :part_number, :retail_price
    def part_params
    	params.require(:part).permit(:description, :part_manufacturer_id, :part_name_id, :part_number, :retail_price)
    end
    belongs_to :part_manufacturer
    belongs_to :part_name
end
