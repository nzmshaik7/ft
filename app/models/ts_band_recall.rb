class TsBandRecall < ActiveRecord::Base
    attr_accessible :date_completed, :name, :vehicle_id
    belongs_to :vehicle
end
