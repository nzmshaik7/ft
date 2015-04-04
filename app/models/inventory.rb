class Inventory < ActiveRecord::Base
    attr_accessible :count, :part_id, :store_id
end
