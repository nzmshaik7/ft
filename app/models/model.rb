class Model < ActiveRecord::Base
    #attr_accessible :first_year_made, :last_year_made, :make_id, :name
    def model_params
	params.require(:model).permit(:first_year_made, :last_year_made, :make_id, :name)
    end
    belongs_to :make
    
end
