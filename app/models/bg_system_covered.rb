class BgSystemCovered < ActiveRecord::Base
    attr_accessible :coverage, :system_id, :vehicle_id
    belongs_to :vehicle
    belongs_to :system
end
