class ServiceVisit < ActiveRecord::Base
    #attr_accessible :comments, :description, :invoice_id, :mileage,
    #                :salesperson_id, :sdate, :store_id, :vehicle_id, :status
    def ServiceVisit_params
    	params.require(:service_visit).permit(:comments, :description, :invoice_id, :mileage,
                    :salesperson_id, :sdate, :store_id, :vehicle_id, :status)
    end
    belongs_to :vehicle
    belongs_to :invoice
    belongs_to :salesperson
    belongs_to :store
    has_many :service_line_items
    has_many :service_journals

    STATUS_ESTIMATE   = 101
    STATUS_CANCELLED  = 102
    STATUS_APPROVED   = 103
    STATUS_INPROGRESS = 104
    STATUS_COMPLETED  = 105
    STATUS_LAST = 105

    STATUS_OPTIONS = [  # Suitable for select dropdown helper
            [ "Select",       0  ],
            [ "Estimate",     STATUS_ESTIMATE ],
            [ "Cancelled",    STATUS_CANCELLED ],
            [ "Approved",     STATUS_APPROVED ],
            [ "In Progress",  STATUS_INPROGRESS ],
            [ "Completed",    STATUS_COMPLETED ],
    ]

    def visitText
        return sdate.strftime("%b %d, %Y/") + mileage.to_s + " mi"
    end


    def statusText
        return "Estimate"     if status == 101
        return "Cancelled"    if status == 102
        return "Approved"     if status == 103
        return "In Progress"  if status == 104
        return "Completed"    if status == 105
        return "Unknown"
    end


    def statusValid?
        return false  if status.nil?
        return false  if status < STATUS_ESTIMATE
        return false  if status > STATUS_LAST
        return true
    end


end
