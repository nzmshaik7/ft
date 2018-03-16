class County < ActiveRecord::Base
    #attr_accessible :name, :state_id
    def county_params
	params.require(:county).permit(:name, :state_id)
    end
    belongs_to :state
end
