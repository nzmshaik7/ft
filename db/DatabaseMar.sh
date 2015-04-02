#!/bin/bash

# DATABASE SCHEMA

function rails() {
    echo rails $*
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
    # Primary keys that point here
    # List of Vehicles
    # List of Invoices
    # List of Payments
    # List of Payment Methods
    # List of FinanceAgreement
rails ${gen[*]}


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
    # Primary keys that point here
    # List of Payments
rails ${gen[*]}


gen=( generate scaffold ReferredBy 
    description:string
    is_other:boolean
    )
rails ${gen[*]}


Contract
    BeginDate
    Number
    Status     # (Current, Lapsed, Cancelled)
    Image id
    Salesperson id
    Level
    BaseCost
    # Primary keys that point here
    List of Upgrades
    DayOfPayment
    Discount     # (amount)
    Discount     # (percentage)

Upgrades
    Contract id
    UpgradeType id
    Cost     # (copied and adjustable)

UpgradeType 
    Name
    Cost

Testimony 
    User Text

Image
    Filename
    Next image id  # Linked list

Vehicle
    VIN
    VinDecoded
    License Plate
    License Plate State id
    Customer id
    Make id
    Model id
    Submodel id
    Date of manufacture
    Country of manufacture
    MSRP
    KBB value on qualification
    Current KBB value
    ConsumeReportsUrl
    Engine cyl
    Engine displacement
    WheelDrive id
    Color id
    Doors
    Convertible
    Comments
    ServiceSchedule id
    Insurance company id
    Insurance policy number
    Insurance image id
    Carfax url
    Carfax copy at qualification
    DoorPlateImage id
    Mileage
    MPG 30 days after initial service
    Photos Image id
    Qualification id
    BGCompliant
    Contract id
    # Primary keys that point here
    List of ServiceVisits
    List of ScheduledAppointments
    List of GasMileages
    List of NonMaMaintenance
    List of CodeHistories
    List of TireTdReadings
    List of BGSystemsCovered
    List of Breakdowns
    List of AutomaticDataLinkInfos
    List of TSBandRecalls
    List of Manufacturer Warranty id

AutomaticDataLinkInfos
    Vehicle id
    SerialNumber
    Date
    Data

TSBandRecalls
    Vehicle id
    Name
    DateCompleted

Breakdowns
    Vehicle id
    Date
    Description

ManufacturerWarranties
    Vehicle id
    Months
    Miles
    Type     # (bumpber/bumper, powertrain, etc)
    Image from customer or dealer

BGSystemsCovered
    Vehicle id
    System id
    Coverage      # (Can be zero to indicate not covered)

BGSystems
    Name

TireTdReadings
    Vehicle id
    Date
    Depth32nds

CodeHistories
    Vehicle id
    Date
    Code
    
Qualification
    Date
    Leakdown
    QualReportImages id
    AlignmentReportImages id
    SixgasReportImages id
    SpectrumReportImages id
    CylinderCompressionSpec
    ServiceVisit id
    # Primary keys that point here
    List of CylinderCompressions

CylinderCompressions
    Qualification id
    CylNum
    PSI

GasMileages
    Vehicle id
    Mileage
    Date

NonMaMaintenance
    Vehicle id
    Date
    Where
    Document Image id

Color
    Name

WheelDrive 
    Name     # (4WD, AWD, etc)


ServiceSchedule
    Image id
    # Primary keys that point here
    List of ScheduledServices

ScheduledServices
    ServiceSchedule id
    Date
    Mileage
    # Primary keys that point here
    List of ScheduledServiceItems

ScheduledServiceItems
    ScheduledServices id
    Name

ScheduledAppointments
    Date and Time
    Actual Date and Time
    Status     # (completed, pending, cancelled)
    Purpose     # (regular service, repair needed)
    Vehicle id
    Store id

ServiceVisit
    Mileage
    Date
    Description
    Store id
    Vehicle id
    Invoice id
    Comments
    # Primary keys that point here
    List of ServiceLineItems
    List of ServiceJournals

ServiceJournals
    ServiceVisit id
    Event id
    Date and Time

ServiceJournalsEvents
    Name

ServiceLineItem
    ServiceVisit id
    ServiceDescription id
    ServiceDescriptionText
    Labor hours retail
    Labor rate retail
    Labor hours actual
    Labor rate actual
    Technician1 id     # (ok if not a list?)
    Technician2 id     # (ok if not a list?)
    Technician3 id     # (ok if not a list?)
    Scheduled or unscheduled
    # Primary keys that point here
    List of ServiceParts

ServiceDescription
    Name
    Labor rate retail
    Labor hours retail

ServiceParts
    ServiceLineItem id
    Part id
    #     # (These are copied from the part since the part may change later.)
    Part retail price
    Part actual price  


Part
    Manufacturer
    Part Name id
    Description
    Part Number
    Actual cost
    Retail price

Part Name 
    Name


Make
    Name


Model
    Name
    Make id
    First year made
    Last year made


Payment
    Date and Time
    Invoice id     # (or InvoiceLineItem?)  # one or the other of these
    Contract id
    FinanceAgreement id
    Customer id
    Amount
    Payment method used
    Status
    MerchantServicesStatus
    Comment


Payment Methods
    Customer id
    Type     # (Visa, ACH, etc.)
    Priority
    Account number id
    Routing number     # (for ACH)
    Expiration Date
    CVV id
    Image id     # (front and back)


Invoice
    Invoice number
    Date and Time
    Customer id
    List of InvoiceLineItems


InvoiceLineItem
    Amount
    Invoice id
    LineItemPurpose id     # (such as monthly membership dues)
    Description     # (optional)
    ServiceVisit id
    Vehicle id

LineItemPurpose
    Name      # (monthly dues, service item, late fee, etc.)


Store
    Name
    Number
    Manager
    Street Address
    City
    State
    County
    Region
    Zip
    Phone
    Number of lifts
    Capactiy     # (in number of contracts)
    BreakEven

Technician
    Employee id
    Level
    Hourly rate

Salesperson
    Employee id


Employee
    First Name
    Last Name
    SSN
    Store id

Inventory
    Store id
    Part id
    Count

# vim :se noexpandtab
