#!/bin/bash

if [ -z "$pw" ]; then
    echo "Set pw first"
    exit 1
fi

opts="-u dlaw -p$pw --no-create-info --skip-comments ft_development"
mysqldump $opts automatic_data_link_infos
mysqldump $opts bg_system_covereds
mysqldump $opts bg_systems
mysqldump $opts breakdowns
mysqldump $opts code_histories
mysqldump $opts colors
mysqldump $opts contracts
mysqldump $opts counties
mysqldump $opts countries
mysqldump $opts customers
mysqldump $opts cylinder_compressions
mysqldump $opts employees
mysqldump $opts engine_displacements
mysqldump $opts finance_agreements
mysqldump $opts gas_mileages
mysqldump $opts images
mysqldump $opts insurance_companies
mysqldump $opts inventories
mysqldump $opts invoice_line_items
mysqldump $opts invoices
mysqldump $opts line_item_purposes
mysqldump $opts makes
mysqldump $opts manufacturer_warranties
mysqldump $opts manufacturer_warranty_types
mysqldump $opts models
mysqldump $opts non_ma_maintenances
mysqldump $opts part_manufacturers
mysqldump $opts part_names
mysqldump $opts parts
mysqldump $opts payment_methods
mysqldump $opts payment_types
mysqldump $opts payments
mysqldump $opts qualifications
mysqldump $opts referred_bies
mysqldump $opts regions
mysqldump $opts salespeople
mysqldump $opts scheduled_appointments
mysqldump $opts scheduled_service_items
mysqldump $opts scheduled_services
mysqldump $opts service_categories
mysqldump $opts service_descriptions
mysqldump $opts service_journals
mysqldump $opts service_journals_events
mysqldump $opts service_line_items
mysqldump $opts service_parts
mysqldump $opts service_schedules
mysqldump $opts service_visits
mysqldump $opts states
mysqldump $opts stores
mysqldump $opts submodels
mysqldump $opts technicians
mysqldump $opts tire_td_readings
mysqldump $opts ts_band_recalls
mysqldump $opts upgrade_types
mysqldump $opts upgrades
mysqldump $opts vehicles
mysqldump $opts wheel_drives
mysqldump $opts written_testimonies
