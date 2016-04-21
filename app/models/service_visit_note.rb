class ServiceVisitNote < ActiveRecord::Base
    attr_accessible :note, :service_visit_id, :user_id
end
