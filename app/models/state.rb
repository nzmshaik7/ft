class State < ActiveRecord::Base
    #attr_accessible :abbrev, :name
    def state_params
      params.require(:state).permit(:abbrev, :name)
    end

end
