class Submodel < ActiveRecord::Base
    #attr_accessible :make_id, :name
    def submodel_params
	params.require(:submodel).permit(:make_id, :name)
    end
    belongs_to :make
end
