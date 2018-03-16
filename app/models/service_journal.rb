class ServiceJournal < ActiveRecord::Base
    #attr_accessible :date_time, :event_id, :service_visit_id
    def service_journal_params
	params.require(:service_journal).permit(:date_time, :event_id, :service_visit_id)
    end
    belongs_to :service_visit
    belongs_to :event, class_name: :ServiceJournalsEvent
end
