class Region < ActiveRecord::Base
    #attr_accessible :name, :state_id
    def region_params
	params.require(:region).permit(:name, :state_id)
    end
    belongs_to :state
end
