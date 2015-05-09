#!/bin/bash

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
