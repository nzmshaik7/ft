class Image < ActiveRecord::Base
    #attr_accessible :filename, :image_id
    def image_params
	params.require(:image).permit(:filename, :image_id)
    end
end
