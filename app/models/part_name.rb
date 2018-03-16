class PartName < ActiveRecord::Base
    #attr_accessible :name
    def partName_params
  	  params.require(:part_name).permit(:name)
    end

    def isOther
        return true if name.downcase == 'other'
        return false
    end
end
