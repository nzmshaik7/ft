class Make < ActiveRecord::Base
    #attr_accessible :name
    def make_params
      params.require(:make).permit(:name)
    end
    has_many :vehicles
    has_many :models
    has_many :submodels
end
