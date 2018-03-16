class WrittenTestimony < ActiveRecord::Base
    #attr_accessible :user_text
    def written_testimony_params
	params.require(:written_testimony).permit(:user_text)
    end
end
