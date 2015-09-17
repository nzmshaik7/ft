class InventoryPart < ActiveRecord::Base
    attr_accessible :part_actual_price, :part_id, :purchase_order_id, :quantity
    belongs_to :part
    belongs_to :purchase_order
end
