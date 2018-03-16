class ServiceJournalsEvent < ActiveRecord::Base
    #attr_accessible :name
    def service_journals_event_params
	params.require(:service_journals_event).permit(:name)
    end
end
