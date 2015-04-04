class ServiceJournal < ActiveRecord::Base
    attr_accessible :date_time, :event_id, :service_visit_id
end
