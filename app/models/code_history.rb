class CodeHistory < ActiveRecord::Base
    attr_accessible :cdate, :code, :vehicle_id
    belongs_to :vehicle
end
