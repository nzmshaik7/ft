class Contract < ActiveRecord::Base
    attr_accessible :base_cost, :begin_date, :day_of_payment, :discount, 
                    :discount, :image_id, :level, :number, :salesperson_id,
                    :status
    belongs_to :image
    belongs_to :salesperson
    has_many :upgrades
end
