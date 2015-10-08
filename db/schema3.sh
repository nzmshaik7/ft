#!/bin/bash

# Record the migration command here
# Run it
# rake db:migrate
# Adjust model and forms

exit 1

rails generate scaffold PaymentType name:string
rails generate migration delete_paytype_from_PaymentMethod paytype:integer
rails generate migration add_payment_type_id_to_PaymentMethod \
                                                   payment_type_id:integer
rails generate migration add_discount_percent_to_Contract \
                                                   discount_percent:integer

rails generate migration add_first_name_to_Customer first_name:string
rails generate migration add_middle_name_to_Customer middle_name:string
rails generate migration add_last_name_to_Customer last_name:string

rails generate migration delete_wtype_from_ManufacturerWarranty wtype:integer
rails generate migration \
                 add_manufacturer_warranty_type_id_to_ManufacturerWarranty  \
		 manufacturer_warranty_type_id:integer

rails generate scaffold ManufacturerWarrantyType name:string \
                                                   --no-assets --no-helper

rails generate migration delete_is_scheduled_from_ServiceLineItem \
                         is_scheduled:boolean
rails generate migration add_stype_to_ServiceLineItem stype:integer

rails generate migration rename_manufacturer_warranty_column
rails generate migration add_email_to_Customer email:string
rails generate migration add_contact_method_to_Customer contact_method:integer
rails generate migration add_cylinder_compression_tolerance_to_Qualification cylinder_compression_tolerance:integer


rails generate migration delete_labor_from_ServiceLineItem \
    labor_hours_retail:decimal{8.2} \
    labor_rate_retail:decimal{8.2} \
    labor_hours_actual:decimal{8.2} \
    labor_rate_actual:decimal{8.2} \
    technician1_id:integer \
    technician2_id:integer \
    technician3_id:integer

rails generate migration add_added_miles_to_UpgradeType added_miles:integer
rails generate migration add_status_to_ServiceVisit status:integer
rails generate migration add_quantity_to_ServicePart quantity:integer

# Create an omnibus purchase order and attach all service parts to it.
rails generate migration add_purchase_order_id_to_ServicePart \
                         purchase_order_id:integer
rails generate migration DropInventoryTable
rails generate migration delete_actual_cost_from_Part "actual_cost:decimal{8.2}"

rails generate migration change_quantity_in_ServicePart
rails generate migration change_quantity_in_InventoryPart
