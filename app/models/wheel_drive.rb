class WheelDrive < ActiveRecord::Base
    #attr_accessible :name
 def user_params
      params.require(:wheel_drive).permit(:name)
    end
end
