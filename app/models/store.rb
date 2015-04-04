class Store < ActiveRecord::Base
    attr_accessible :break_even, :capacity, :city, :county_id, :manager_id, :name, :number, :number_of_lifts, :phone, :region_id, :state_id, :street_address, :zip
end
