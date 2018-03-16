class PartManufacturer < ActiveRecord::Base
    #attr_accessible :name
    def part_manufacturer_params
   	 params.require(part_manufacturer).permit(:name)
    end
end
