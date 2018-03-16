class EngineDisplacement < ActiveRecord::Base
    #attr_accessible :name
 def engine_displacement_params
      params.require(:engine_displacement).permit(:name)
    end

    def isOther
        return true if name.downcase == 'other'
        return false
    end
end
