class Inventory < ActiveRecord::Base
    attr_accessible :count, :part_id, :store_id
    belongs_to :store
    belongs_to :part
end
