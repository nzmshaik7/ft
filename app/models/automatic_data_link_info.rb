class AutomaticDataLinkInfo < ActiveRecord::Base
    attr_accessible :data, :idate, :serial_number, :vehicle_id
    belongs_to :vehicle
end
