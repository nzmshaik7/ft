class StoreStock < ActiveRecord::Base

    def store_stock_params
      params.require(:store_stock).permit(:store_id, :part_manufacturer_id, :part_name_id, :inventory_parts,
			 :used_parts, :available_parts)
    end
    belongs_to :store
    belongs_to :part_manufacturer
    belongs_to :part_name
end
