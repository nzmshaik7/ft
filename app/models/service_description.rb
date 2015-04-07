class ServiceDescription < ActiveRecord::Base
    attr_accessible :labor_hours_retail, :labor_rate_retail, :name,
                    :service_category_id
    belongs_to :service_category

    def isOther
        return true if name.downcase == 'other'
        return false
    end
end
