class ReferredBy < ActiveRecord::Base
    #attr_accessible :description, :is_other

    def referred_by_params
       params.require(:referred_by).permit(:description, :is_other)
    end

    def isNone
        return true if description.downcase == 'none'
        return false
    end
end
