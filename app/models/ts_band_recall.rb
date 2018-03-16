class TsBandRecall < ActiveRecord::Base
    #attr_accessible :date_completed, :name, :vehicle_id
    def ts_band_recall_params
	params.require(:ts_band_recall).permit(:date_completed, :name, :vehicle_id)
    end
    belongs_to :vehicle
end
