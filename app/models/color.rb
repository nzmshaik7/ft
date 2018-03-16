class Color < ActiveRecord::Base
    #attr_accessible :name
 def color_params
      params.require(:color).permit(:name)
    end
end



class ColorCount < ActiveRecord::Base

 def color_count_params
	params.require(:color_count).permit(:name, :count)
    end
end


