class ServiceVisitNote < ActiveRecord::Base
    #attr_accessible :note, :service_visit_id, :user_id
    def service_visit_note_params
	params.require(:service_visit_note).permit(:note, :service_visit_id, :user_id)
    end
end
