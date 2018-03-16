class BgSystem < ActiveRecord::Base
    #attr_accessible :name
    def bg_system_params
	params.require(:bg_system).permit(:name)
    end
end
