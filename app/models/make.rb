class Make < ActiveRecord::Base
    attr_accessible :name
    has_many :vehicles
    has_many :models
    has_many :submodels
end
