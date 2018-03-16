class CodeHistory < ActiveRecord::Base
    #attr_accessible :cdate, :code, :vehicle_id
    def code_history_params
	params.require(:code_history).permit(:cdate, :code, :vehicle_id)
    end
    belongs_to :vehicle
end
