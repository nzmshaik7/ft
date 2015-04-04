class ServiceDescription < ActiveRecord::Base
    attr_accessible :labor_hours_retail, :labor_rate_retail, :name, :service_category_id
end
