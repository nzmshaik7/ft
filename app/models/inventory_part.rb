class InventoryPart < ActiveRecord::Base
    #attr_accessible :part_actual_price, :part_id, :purchase_order_id, :quantity
    def inventory_part_params
	params.require(:inventory_part).permit(:part_actual_price, :part_id, :purchase_order_id, :quantity)
    end
    belongs_to :part
    belongs_to :purchase_order
end
