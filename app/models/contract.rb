class Contract < ActiveRecord::Base
    #attr_accessible :base_cost, :begin_date, :day_of_payment, :discount, 
    #                :discount, :image_id, :level, :number, :salesperson_id,
    #                :status, :discount_percent
    def contract_params
      params.require(:contract).permit(:store_id, :base_cost, :begin_date, :day_of_payment, :discount, 
                    :discount, :image_id, :level, :number, :salesperson_id,
                    :status, :discount_percent)
    end
    belongs_to :store
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

    def base_costText
	return "29.99" if base_cost == 1
	return "39.99" if base_cost == 2
	return "49.99" if base_cost == 3
	return "69.99" if base_cost == 4
	return "99.99" if base_cost == 5
	return "Unknown"
    end

end

