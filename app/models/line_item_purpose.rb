class LineItemPurpose < ActiveRecord::Base
    attr_accessible :name

    def isOther
        return true if name.downcase == 'other'
        return false
    end
end
