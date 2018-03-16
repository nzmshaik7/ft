class Store < ActiveRecord::Base
   # attr_accessible :break_even, :capacity, :city, :county_id, :manager_id,
   #                 :name, :number, :number_of_lifts, :phone, :region_id,
   #                 :state_id, :street_address, :zip
	
    def store_params
      params.require(:store).permit(:break_even, :capacity, :city, :county_id, :manager_id,
                    :name, :number, :number_of_lifts, :phone, :region_id,
                    :state_id, :street_address, :zip)
    end
    belongs_to :county
    belongs_to :region
    belongs_to :state
    belongs_to :manager, class_name: :Employee
end
