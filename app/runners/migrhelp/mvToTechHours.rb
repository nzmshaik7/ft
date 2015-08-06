# Basically, we refactored tech-hours out of service line items and
# into a new table, TechnicianHour.  That includes deleting the
# technician data out of service line item:
# belongs_to :technician1, class_name: :Technician
# belongs_to :technician2, class_name: :Technician
# belongs_to :technician3, class_name: :Technician
#
# So for the live database, we need to run just the migration to 
# create technician_hours:
#     rake db:migrate:up VERSION=20150710210730
#
# Then run this script
# Then run a regular migrate to delete the columns.

class MvToTechHours

    def doit()
        print "----------------------------------------------------\n"
        for sli in ServiceLineItem.all
            nonZero = 0
            nonZero += 1  if sli.technician1_id != 0
            nonZero += 1  if sli.technician2_id != 0
            nonZero += 1  if sli.technician3_id != 0
            if nonZero > 1
                print "ERROR: Too many techs on sli #{sli.id}\n"
                next
            end
            if sli.technician1_id != 0
                print "Making new tech hours for sli #{sli.id}\n"
                TechnicianHour.create(service_line_item_id: sli.id,
                              labor_hours_retail: sli.labor_hours_retail,
                              labor_rate_retail: sli.labor_rate_retail,
                              labor_hours_actual: sli.labor_hours_actual,
                              labor_rate_actual: sli.labor_rate_actual,
                              technician_id: sli.technician1_id)
            end
            if sli.technician2_id != 0
                print "Making new tech hours for sli #{sli.id}\n"
                TechnicianHour.create(service_line_item_id: sli.id,
                              labor_hours_retail: sli.labor_hours_retail,
                              labor_rate_retail: sli.labor_rate_retail,
                              labor_hours_actual: sli.labor_hours_actual,
                              labor_rate_actual: sli.labor_rate_actual,
                              technician_id: sli.technician2_id)
            end
            if sli.technician3_id != 0
                print "Making new tech hours for sli #{sli.id}\n"
                TechnicianHour.create(service_line_item_id: sli.id,
                              labor_hours_retail: sli.labor_hours_retail,
                              labor_rate_retail: sli.labor_rate_retail,
                              labor_hours_actual: sli.labor_hours_actual,
                              labor_rate_actual: sli.labor_rate_actual,
                              technician_id: sli.technician3_id)
            end
        end
        puts "Conversion complete."
    end

end

mtth = MvToTechHours.new
mtth.doit
