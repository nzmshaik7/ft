#!/bin/bash

# After adding a table:
# 2to4 on model and controller
# add to top/db.html.erb
# Make index look like table
# Put permission restrictions on controllers
# In create and update, change
# format.html { redirect_to @region, notice ...
# to
# format.html { redirect_to regions_url, notice ...
# Add prepFormVariables for *_id if needed.

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
## RAILS ${gen[*]}

# Changes to track the cost of an indivudual part through its life cycle.


gen=( generate scaffold Vendor
    name:string
    )
RAILS ${gen[*]}


gen=( generate scaffold PurchaseOrder
    po_number:string
    vendor_id:integer
    date_time:datetime          # When it was ordered.
    # List of InventoryParts
    # List of ServiceParts
    # may add services later, such as rotor turning, etc.
    )
RAILS ${gen[*]}


gen=( generate scaffold InventoryPart
    purchase_order_id:integer
    part_id:integer
    quantity:integer
    part_actual_price:decimal{8.2}
    )
RAILS ${gen[*]}


gen=( generate scaffold VendorInvoice
    invoice_number:string
    date_time:datetime          # When it was created
    vendor_id:integer
    status:integer              # Paid, Unpaid, etc.
    purchase_order_id:integer
    )
RAILS ${gen[*]}
