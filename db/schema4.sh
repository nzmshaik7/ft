#!/bin/bash

# DATABASE SCHEMA

function RAILS() {
    echo " "
    echo rails $*
    echo " "
    echo -n "enter: "
    read ans
    rails $* --no-assets --no-helper
}



# One Technician working on one service line item.  One service line
# item might have several of these.
#
gen=( generate scaffold TechnicianHour
    service_line_item_id:integer
    labor_hours_retail:decimal{8.2}
    labor_rate_retail:decimal{8.2}
    labor_hours_actual:decimal{8.2}
    labor_rate_actual:decimal{8.2}
    technician_id:integer
    )
RAILS ${gen[*]}
