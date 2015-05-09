class ReferredBy < ActiveRecord::Base
    attr_accessible :description, :is_other

    def isNone
        return true if description.downcase == 'none'
        return false
    end
end
