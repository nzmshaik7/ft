class ServiceJournal < ActiveRecord::Base
    attr_accessible :date_time, :event_id, :service_visit_id
    belongs_to :service_visit
    belongs_to :event, class_name: :ServiceJournalsEvent
end
