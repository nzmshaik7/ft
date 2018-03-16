class Inventory < ActiveRecord::Base
    #attr_accessible :count, :part_id, :store_id
    def inventory_params
	params.require(:inventory).permit(:count, :part_id, :store_id)
    end
    belongs_to :store
    belongs_to :part
end
