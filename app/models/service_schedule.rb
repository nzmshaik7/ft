class ServiceSchedule < ActiveRecord::Base
    attr_accessible :image_id
    belongs_to :image
    has_many :scheduled_services
end
