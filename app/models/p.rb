class P < ActiveRecord::Base
    #attr_accessible :name
 def p_params
      params.require(:p).permit(:name)
    end

    def isOther
        return true if name.downcase == 'other'
        return false
    end
end
