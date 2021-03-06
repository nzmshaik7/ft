OBSOLETE

This was used initially, but changes have been made.
See db/DatabaseLatest.txt















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


gen=( generate scaffold Customer 
    cid:string
    user_id:integer                 # User has first/last names and email
    street_addr1:string
    street_addr2:string
    city:string
    state_id:integer
    zip:string
    home_phone:string
    can_text_home_phone:boolean
    work_phone:string
    can_text_work_phone:boolean
    mobile_phone:string
    can_text_mobile_phone:boolean
    other_phone:string
    can_text_other_phone:boolean
    joined_date:datetime
    is_aaa_member:boolean
    is_web_registered:boolean
    spouse_name:string
    spouse_id:integer               # Could point to another Customer
    signup_store_id:integer         # Point to a Store object
    referredBy_id:integer           # Points to ReferredBy table
    referredBy_customer_id:integer  # Points to another customer
    referredBy_other_text:string    # When referredBy_id is Other
    ssn:string
    driver_lic_num:string
    driver_lic_state_id:integer
    driver_lic_image_id:integer
    date_of_birth:datetime
    gender:integer                  # Constants in Customer model
    video_testimony_url:string
    written_testimony_id:integer
    referral_credits_earned:integer
    referral_credits_used:integer
    )
    # Other tables that point to my Primary Key
    # List of Vehicles
    # List of Invoices
    # List of Payments
    # List of Payment Methods
    # List of FinanceAgreement
# RAILS ${gen[*]}


gen=( generate scaffold FinanceAgreement
    customer_id:integer
    missed_payment_fee:decimal{8.2}     # Cumulative
    total_principal:decimal{8.2}
    finance_fee:decimal{8.2}            # Typically 10%
    monthly_payment_amount:decimal{8.2}
    start_date:datetime
    end_date:datetime
    title_image_id:integer
    agreement_image_id:integer
    )
    # Other tables that point to my Primary Key
    # List of Payments
RAILS ${gen[*]}


# This is a dropdown.  Customer table has pointer to one of these selections.
# If is_other is true, then this selection is "Other" and more information
# is in the Customer table.
gen=( generate scaffold ReferredBy 
    description:string
    is_other:boolean
    )
RAILS ${gen[*]}


# One vehicle, one contract.  Vehicle table points here.
gen=( generate scaffold Contract
    begin_date:datetime
    number:string             # Contract number on contract
    status:integer            # (Current, Lapsed, Cancelled)
    image_id:integer
    salesperson_id:integer
    level:integer             # Level of car (Level 1, Level 2, etc.)
    base_cost:decimal{8.2}
    day_of_payment:integer    # Day of month automatic payment is made
    discount:decimal{8.2}     # (amount)
    discount:integer          # (percentage)
    )
    # Other tables that point to my Primary Key
    # List of Upgrades
RAILS ${gen[*]}


# Upgrades that apply to particular vehicles/contracts.  Points back to
# the relevant contract.
gen=( generate scaffold Upgrade
    contract_id:integer       # Many to one
    upgrade_type_id:integer   # Which upgrade this is
    cost:decimal{8.2}         # Copied from UpgradeType, and adjustable
    )
RAILS ${gen[*]}


# This is a dropdown.  Upgrades points here.
gen=( generate scaffold UpgradeType 
    name:string
    cost:decimal{8.2}
    )
RAILS ${gen[*]}


# Customer table points here
gen=( generate scaffold WrittenTestimony 
    user_text:text
    )
RAILS ${gen[*]}


# Multi-purpose collection of images.  Lets single image id pointer
# in another table point here, where every row could be 1 image or 
# the start of a linked list of images.
# filename is relative to the images directory and probably will
# have a subdirectory in it.
gen=( generate scaffold Image
    filename:string
    image_id:integer  # Next image in linked list
    )
RAILS ${gen[*]}


gen=( generate scaffold Vehicle
    vin:string
    vin_decoded:string
    license_plate:string
    license_plate_state_id:integer
    customer_id:integer             # Many to one
    make_id:integer
    model_id:integer
    submodel_id:integer
    date_of_manufacture:datetime
    country_of_manufacture_id:integer
    msrp:decimal{8.2}
    kbb_on_qual:decimal{8.2}
    current_kbb:decimal{8.2}
    consumer_reports_url:string
    engine_cyl:integer
    engine_displacement_id:integer
    wheel_drive_id:integer
    color_id:integer
    doors:integer
    convertible:boolean
    comments:text
    # There is one particular service schedule for this vehicle.  Form
    # is filled out on qual.  This points to it.
    service_schedule_id:integer
    insurance_company_id:integer
    insurance_policy_number:string
    insurance_image_id:integer
    carfax_url:string
    carfax_copy_at_qual:string
    door_plate_image_id:integer
    mileage:integer
    mpg30after_initial:decimal{8.2}
    photos_image_id:integer
    # Set of information collected at qualification
    qualification_id:integer
    bg_compliant:boolean
    contract_id:integer        # This vehicle has one contract
    )
    # Other tables that point to my Primary Key
    # List of ServiceVisits
    # List of ScheduledAppointments
    # List of GasMileages
    # List of NonMaMaintenance
    # List of CodeHistories
    # List of TireTdReadings
    # List of BGSystemsCovered
    # List of Breakdowns
    # List of AutomaticDataLinkInfos
    # List of TSBandRecalls
    # List of Manufacturer Warranty id
RAILS ${gen[*]}


gen=( generate scaffold AutomaticDataLinkInfo
    vehicle_id:integer
    serial_number:string
    idate:datetime
    data:text
    )
RAILS ${gen[*]}


gen=( generate scaffold TSBandRecall
    vehicle_id:integer
    name:string
    date_completed:datetime
    )
RAILS ${gen[*]}


gen=( generate scaffold Breakdown
    vehicle_id:integer
    bdate:datetime
    description:text
    )
RAILS ${gen[*]}


gen=( generate scaffold ManufacturerWarranty
    vehicle_id:integer
    months:integer
    miles:integer
    wtype:integer     # (bumpber/bumper, powertrain, etc)
    image:integer     # from_customer_or_dealer
    comment:string
    )
RAILS ${gen[*]}


gen=( generate scaffold BGSystemCovered
    vehicle_id:integer
    system_id:integer
    coverage:integer      # (Can be zero to indicate not covered)
    )
RAILS ${gen[*]}


gen=( generate scaffold BGSystem
    name:string
    )
RAILS ${gen[*]}


gen=( generate scaffold TireTdReading
    vehicle_id:integer
    tdate:datetime
    depth32nds:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold CodeHistory
    vehicle_id:integer
    cdate:datetime
    code:string
    )
RAILS ${gen[*]}

    
gen=( generate scaffold Qualification
    qdate:datetime
    leakdown:integer
    qual_report_images_id:integer
    alignment_report_images_id:integer
    sixgas_report_images_id:integer
    spectrum_report_images_id:integer
    cylinder_compression_spec:integer
    service_visit_id:integer
    )
    # Other tables that point to my Primary Key
    # List of CylinderCompressions
RAILS ${gen[*]}


gen=( generate scaffold CylinderCompression
    qualification_id:integer
    cyl_num:integer
    psi:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold GasMileage
    vehicle_id:integer
    mileage:decimal{8.2}
    mdate:datetime
    )
RAILS ${gen[*]}


gen=( generate scaffold NonMaMaintenance
    vehicle_id:integer
    mdate:datetime
    where:string
    document_image_id:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold Color
    name:string
    )
RAILS ${gen[*]}


gen=( generate scaffold WheelDrive 
    name:string     # 4WD, AWD, etc.
    )
RAILS ${gen[*]}


# Every vehicle has one pointer to one of these, the unique service
# schedule for that particular vehicle.
gen=( generate scaffold ServiceSchedule
    image_id:integer
    )
    # Other tables that point to my Primary Key
    # List of ScheduledServices
RAILS ${gen[*]}


# One particular time or mileage level, whichever comes first, where
# this vehicle needs to come in for scheduled service.
gen=( generate scaffold ScheduledService
    service_schedule_id:integer
    sdate:datetime
    mileage:integer
    )
    # Other tables that point to my Primary Key
    # List of ScheduledServiceItems
RAILS ${gen[*]}


# Items that need to be serviced during a particular ScheduledService.
gen=( generate scaffold ScheduledServiceItem
    scheduled_service_id:integer
    service_description_id:integer
    other:string  # Only used if service_description_id points to Other.
    )
RAILS ${gen[*]}


gen=( generate scaffold ScheduledAppointment
    date_time:datetime  # If date_time is in the near past, we still call
                        # it pending.  After it missed the allowed deadline,
			# it becomes missed.  If the customer cancels it,
			# it is cancelled.
    actual_date_time:datetime
    status:integer      # (completed, pending, cancelled, missed)
    purpose:integer     # (regular service, repair needed)
    vehicle_id:integer
    store_id:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold ServiceVisit
    mileage:integer
    sdate:datetime
    description:string
    store_id:integer
    vehicle_id:integer
    invoice_id:integer
    salesperson_id:integer
    comments:text
    )
    # Other tables that point to my Primary Key
    # List of ServiceLineItems
    # List of ServiceJournals
RAILS ${gen[*]}


gen=( generate scaffold ServiceJournal
    service_visit_id:integer
    event_id:integer
    date_time:datetime
    )
RAILS ${gen[*]}


gen=( generate scaffold ServiceJournalsEvent
    name:string
    )
RAILS ${gen[*]}


gen=( generate scaffold ServiceLineItem
    service_visit_id:integer
    service_description_id:integer
    service_description_text:string
    labor_hours_retail:decimal{8.2}
    labor_rate_retail:decimal{8.2}
    labor_hours_actual:decimal{8.2}
    labor_rate_actual:decimal{8.2}
    technician1_id:integer     # ok if not a list?
    technician2_id:integer
    technician3_id:integer
    is_scheduled:boolean
    )
    # Other tables that point to my Primary Key
    # List of ServiceParts
RAILS ${gen[*]}


# Dropdown of canned service items.  One item will be "Other" so that
# objects can have an arbitrary field.  Category is to help organize
# the UI, since one linear dropdown will probably be too long.
gen=( generate scaffold ServiceDescription
    name:string
    service_category_id:integer
    labor_rate_retail:decimal{8.2}
    labor_hours_retail:decimal{8.2}
    )
RAILS ${gen[*]}


gen=( generate scaffold ServiceCategory
    name:string
    )
RAILS ${gen[*]}


# A particular part that was used for one service line item.  The prices
# are copied from the part because the part prices may change later.
gen=( generate scaffold ServicePart
    service_line_item_id:integer
    part_id:integer
    # (These are copied from the part since the part may change later:
    part_retail_price:decimal{8.2}
    part_actual_price:decimal{8.2}
    )
RAILS ${gen[*]}


gen=( generate scaffold Part
    part_manufacturer_id:integer
    part_name_id:integer   # Can be Other
    description:string     # Optional
    part_number:string
    actual_cost:decimal{8.2}
    retail_price:decimal{8.2}
    )
RAILS ${gen[*]}


gen=( generate scaffold PartManufacturer
    name:string
    )
RAILS ${gen[*]}


gen=( generate scaffold PartName 
    name:string  # Has to include Other
    )
RAILS ${gen[*]}


gen=( generate scaffold Make
    name:string
    )
RAILS ${gen[*]}


gen=( generate scaffold Model
    name:string
    make_id:integer
    first_year_made:integer  # Full integer year, i.e. 2008, not 8.
    last_year_made:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold Submodel
    name:string
    make_id:integer
    )
RAILS ${gen[*]}


# Dropdown.  Can contain Other.
gen=( generate scaffold EngineDisplacement
    name:string
    )
RAILS ${gen[*]}


# A payment that has been made.
gen=( generate scaffold Payment
    date_time:datetime
     invoice_id:integer     # (or InvoiceLineItem?)  # one or the other of these
     contract_id:integer
     finance_agreement_id:integer
    customer_id:integer
    amount:decimal{8.2}
    payment_method_id:integer
    status:integer            # Approved, Denied
    merchant_services_status:string  # String back from bank
    comment:string
    )
RAILS ${gen[*]}


gen=( generate scaffold PaymentMethod
    customer_id:integer
    paytype:integer             # Visa, Discover, ACH, etc.
    priority:integer            # Order the customer would like to try payment.
    account_number_id:integer   # This is an ID because the actual account 
                                # number is over on a separate system.
    routing_number:string       # For ACH.
    expiration_month:integer    # 1-12
    expiration_year:integer     # Full year, 4 digits
    image_id:integer            # (front and back), separate system.
    )
RAILS ${gen[*]}


gen=( generate scaffold Invoice
    invoice_number:string
    date_time:datetime          # When it was created
    customer_id:integer
    status:integer              # Paid, Unpaid, etc.
    )
    # List of InvoiceLineItems
RAILS ${gen[*]}


gen=( generate scaffold InvoiceLineItem
    amount:decimal{8.2}
    invoice_id:integer
    line_item_purpose_id:integer     # monthly membership dues, etc.
    description:string               # optional
    service_visit_id:integer
    vehicle_id:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold LineItemPurpose
    name      # (monthly dues, service item, late fee, Other, etc.)
    )
RAILS ${gen[*]}


gen=( generate scaffold Store
    name:string
    number:string
    manager_id:integer      # Points to an Employee
    street_address:string
    city:string
    state_id:integer
    county_id:integer
    region_id:integer
    zip:string
    phone:string
    number_of_lifts:integer
    capacity:integer     # in number of contracts
    break_even:integer   # in number of contracts
    )
RAILS ${gen[*]}


gen=( generate scaffold Technician
    employee_id:integer
    level:integer
    hourly_rate:decimal{8.2}
    )
RAILS ${gen[*]}


gen=( generate scaffold Salesperson
    employee_id:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold Employee
    first_name:string
    last_name:string
    ssn:string
    store_id:integer
    )
RAILS ${gen[*]}


gen=( generate scaffold Inventory
    store_id:integer
    part_id:integer
    count:integer
    )
RAILS ${gen[*]}


# regions within states
gen=( generate scaffold Region
    name:string
    state_id:integer
    )
RAILS ${gen[*]}


# counties within states
gen=( generate scaffold County
    name:string
    state_id:integer
    )
RAILS ${gen[*]}


# all 50 states
gen=( generate scaffold State
    name:string
    abbrev:string
    )
RAILS ${gen[*]}


# Countries that make cars
gen=( generate scaffold Country
    name:string
    abbrev:string
    )
RAILS ${gen[*]}


gen=( generate scaffold InsuranceCompany
    name:string
    )
RAILS ${gen[*]}

# vim :se noexpandtab
