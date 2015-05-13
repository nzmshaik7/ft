module VehiclesHelper

    def countryOrUnk(veh)
        return 'unknown'  if veh.country_of_manufacture.nil?
        return veh.country_of_manufacture.name
    end

end
