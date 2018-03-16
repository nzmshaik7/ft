class StorePart < ActiveRecord::Base
   
    def store_part_params
    	params.require(:store_part).permit(:store_id, :part_id, :quantity, :created_at, :updated_at)
    end
    belongs_to :part
    belongs_to :store
end
