class AutomaticDataLinkInfo < ActiveRecord::Base
    #attr_accessible :data, :idate, :serial_number, :vehicle_id
    def automatic_data_link_info_params
	params.require(:automatic_data_link_info).permit(:data, :idate, :serial_number, :vehicle_id)
    end
    belongs_to :vehicle
end
