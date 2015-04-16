class Contract < ActiveRecord::Base
    attr_accessible :base_cost, :begin_date, :day_of_payment, :discount, 
                    :discount, :image_id, :level, :number, :salesperson_id,
                    :status, :discount_percent
    belongs_to :image
    belongs_to :salesperson
    has_many :upgrades

    STATUS_CURRENT =   51
    STATUS_LAPSED =    52
    STATUS_CANCELLED = 53

    def statusText
        return "Current"      if status == STATUS_CURRENT
        return "Lapsed"       if status == STATUS_LAPSED 
        return "Cancelled"    if status == STATUS_CANCELLED 
        return "Unknown"
    end
end
