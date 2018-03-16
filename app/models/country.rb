class Country < ActiveRecord::Base
    #attr_accessible :abbrev, :name
 def country_params
      params.require(:country).permit(:abbrev, :name)
    end
end
