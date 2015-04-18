class Employee < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :ssn, :store_id
    belongs_to :store

    def nameText
        return first_name + ' ' + last_name
    end
end
