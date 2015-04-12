class Contract < ActiveRecord::Base
    attr_accessible :base_cost, :begin_date, :day_of_payment, :discount, 
                    :discount, :image_id, :level, :number, :salesperson_id,
                    :status, :discount_percent
    belongs_to :image
    belongs_to :salesperson
    has_many :upgrades

    def statusText
        return "Current"      if status == 51
        return "Lapsed"       if status == 52
        return "Cancelled"    if status == 53
        return "Unknown"
    end
end
