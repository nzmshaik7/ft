class Employee < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :ssn, :store_id
end
