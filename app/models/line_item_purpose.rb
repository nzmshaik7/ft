class LineItemPurpose < ActiveRecord::Base
    #attr_accessible :name
    def line_item_purpose_params
	params.require(line_item_purpose).permit(:name)
    end

    def isOther
        return true if name.downcase == 'other'
        return false
    end
end
