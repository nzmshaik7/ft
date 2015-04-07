class Model < ActiveRecord::Base
    attr_accessible :first_year_made, :last_year_made, :make_id, :name
    belongs_to :make
end
