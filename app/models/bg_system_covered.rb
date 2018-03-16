class BgSystemCovered < ActiveRecord::Base
    #attr_accessible :coverage, :system_id, :vehicle_id
    def bg_system_covered_params
	params.require(:bg_system_covered).permit(:coverage, :system_id, :vehicle_id)
    end
    belongs_to :vehicle
    belongs_to :system, class_name: :BgSystem
end
