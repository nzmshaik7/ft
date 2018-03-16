# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180307215218) do

  create_table "automatic_data_link_infos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.string "serial_number"
    t.datetime "idate"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "backups", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "table_name"
    t.integer "user_id"
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bg_system_covereds", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.integer "system_id"
    t.integer "coverage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bg_systems", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "breakdowns", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.datetime "bdate"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cboxinfo", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "code"
    t.text "info"
    t.integer "orderby"
    t.boolean "active"
  end

  create_table "code_histories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.datetime "cdate"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "store_id", null: false
    t.datetime "begin_date"
    t.float "base_cost", limit: 53, null: false
    t.string "number"
    t.integer "status"
    t.integer "image_id"
    t.integer "salesperson_id"
    t.integer "level"
    t.decimal "discount", precision: 10
    t.integer "day_of_payment"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "discount_percent"
  end

  create_table "counties", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "abbrev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "cid"
    t.integer "user_id"
    t.string "street_addr1"
    t.string "street_addr2"
    t.string "city"
    t.integer "state_id"
    t.string "zip"
    t.string "home_phone"
    t.boolean "can_text_home_phone"
    t.string "work_phone"
    t.boolean "can_text_work_phone"
    t.string "mobile_phone"
    t.boolean "can_text_mobile_phone"
    t.string "other_phone"
    t.boolean "can_text_other_phone"
    t.datetime "joined_date"
    t.boolean "is_aaa_member"
    t.boolean "is_web_registered"
    t.integer "signup_store_id"
    t.integer "referredBy_id"
    t.integer "referredBy_customer_id"
    t.string "referredBy_other_text"
    t.string "ssn"
    t.string "driver_lic_num"
    t.integer "driver_lic_state_id"
    t.integer "driver_lic_image_id"
    t.datetime "date_of_birth"
    t.integer "gender"
    t.string "video_testimony_url"
    t.integer "written_testimony_id"
    t.integer "referral_credits_earned"
    t.integer "referral_credits_used"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email"
    t.integer "contact_method"
    t.string "company"
    t.string "remarks"
    t.integer "alternative"
    t.text "alternative_other"
    t.text "license"
    t.text "home_phone_ext"
    t.text "work_phone_ext"
    t.text "mobile_phone_ext"
  end

  create_table "cylinder_compressions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "qualification_id"
    t.integer "cyl_num"
    t.integer "psi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "employees", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "store_id"
    t.string "category_id", limit: 20
    t.string "level", limit: 10
    t.string "email", limit: 45
    t.string "username", limit: 45
    t.string "password", limit: 45
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["username"], name: "username_UNIQUE", unique: true
  end

  create_table "engine_displacements", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "finance_agreements", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "customer_id"
    t.decimal "missed_payment_fee", precision: 8, scale: 2
    t.decimal "total_principal", precision: 8, scale: 2
    t.decimal "finance_fee", precision: 8, scale: 2
    t.decimal "monthly_payment_amount", precision: 8, scale: 2
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "title_image_id"
    t.integer "agreement_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gas_mileages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.decimal "mileage", precision: 8, scale: 2
    t.datetime "mdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "filename"
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurance_companies", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_parts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "inv_purchase_order_id"
    t.integer "store_id", null: false
    t.integer "part_id"
    t.decimal "quantity", precision: 8, scale: 2
    t.float "part_actual_price", limit: 53
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "inventory_purchase_orders", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "part_id"
    t.integer "quantity"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "store_id"
  end

  create_table "invoice_line_items", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.integer "invoice_id"
    t.integer "line_item_purpose_id"
    t.string "description"
    t.integer "service_visit_id"
    t.integer "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "invoice_number"
    t.datetime "date_time", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "service_visit_id", null: false
    t.integer "status"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "line_item_purposes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "name"
    t.text "code"
    t.bigint "store"
  end

  create_table "makes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "manufacturer_warranties", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.integer "months"
    t.integer "miles"
    t.integer "image_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manufacturer_warranty_type_id"
  end

  create_table "manufacturer_warranty_types", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mobileapikey", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "apikey", null: false
  end

  create_table "mobileappointments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "date", null: false
    t.string "fromtime", null: false
    t.string "totime", null: false
    t.string "notes", limit: 500, null: false
    t.integer "store_id", null: false
  end

  create_table "mobilenotifications", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean "unread", null: false
    t.string "subject", null: false
    t.string "body", limit: 1000, null: false
    t.integer "user_id", null: false
  end

  create_table "mobiletrips", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "id", null: false
    t.integer "vehicleid", null: false
    t.string "date", null: false
    t.integer "odometerstart", null: false
    t.integer "odometerend", null: false
    t.float "pricepg", limit: 53, null: false
    t.float "gallonsfilled", limit: 53, null: false
    t.integer "user_id", null: false
  end

  create_table "mobileusers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean "verified", default: false, null: false
    t.string "email", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.string "password", null: false
    t.string "salt", null: false
    t.integer "contract_id", default: -1, null: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "cellphone", null: false
    t.index ["id"], name: "id"
  end

  create_table "mobilevehicles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "id", null: false
    t.binary "img", limit: 4294967295, null: false
    t.string "name", null: false
    t.string "year", null: false
    t.string "make", null: false
    t.string "model", null: false
    t.string "submodel", null: false
    t.integer "user_id", null: false
  end

  create_table "mobileverification", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "token", null: false
    t.date "expire_date", null: false
    t.integer "type", null: false
  end

  create_table "models", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "make_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "non_ma_maintenances", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.datetime "mdate"
    t.string "where"
    t.integer "document_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parking", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.binary "carpic", limit: 4294967295, null: false
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.integer "user_id", null: false
    t.index ["id"], name: "idx_parking_id", unique: true
  end

  create_table "part_manufacturers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "part_names", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "part_manufacturer_id"
    t.integer "part_name_id"
    t.string "description"
    t.string "part_number"
    t.decimal "retail_price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_name_id"], name: "part_name_id_idx"
  end

  create_table "payment_methods", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "customer_id"
    t.integer "priority"
    t.string "account_number_id", limit: 25
    t.string "routing_number"
    t.integer "expiration_month"
    t.integer "expiration_year"
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_type_id"
    t.integer "cvv"
  end

  create_table "payment_types", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "date_time"
    t.integer "invoice_id"
    t.integer "contract_id"
    t.integer "finance_agreement_id"
    t.integer "customer_id"
    t.decimal "amount", precision: 8, scale: 2
    t.integer "payment_method_id"
    t.integer "status"
    t.string "merchant_services_status"
    t.string "comment"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "ps", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "sample table to observe functionality" do |t|
    t.string "name", limit: 45, null: false
  end

  create_table "purchase_orders", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "po_number"
    t.integer "service_line_item_id"
    t.integer "part_id"
    t.integer "quantity"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "qdata", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_visit_id"
    t.string "1", limit: 45
    t.string "2", limit: 45
    t.string "3", limit: 45
    t.string "4", limit: 45
    t.string "5", limit: 45
    t.string "6", limit: 45
    t.string "7", limit: 45
    t.string "8", limit: 45
    t.string "9", limit: 45
    t.string "10", limit: 45
    t.string "11", limit: 45
    t.string "12", limit: 45
    t.string "13", limit: 45
    t.string "14", limit: 45
    t.string "15", limit: 45
    t.string "16", limit: 45
    t.string "17", limit: 45
    t.string "18", limit: 45
    t.string "19", limit: 45
    t.string "20", limit: 45
    t.string "21", limit: 45
    t.string "22", limit: 45
    t.string "23", limit: 45
    t.string "24", limit: 45
    t.string "25", limit: 45
    t.string "26", limit: 45
    t.string "27", limit: 45
    t.string "28", limit: 45
    t.string "29", limit: 45
    t.string "30", limit: 45
    t.string "31", limit: 45
    t.string "32", limit: 45
    t.string "33", limit: 45
    t.string "34", limit: 45
    t.string "35", limit: 45
    t.string "36", limit: 45
    t.string "37", limit: 45
    t.string "38", limit: 45
    t.string "39", limit: 45
    t.string "40", limit: 45
    t.string "41", limit: 45
    t.string "42", limit: 45
    t.string "43", limit: 45
    t.string "44", limit: 45
    t.string "45", limit: 45
    t.string "46", limit: 45
    t.string "47", limit: 45
    t.string "48", limit: 45
    t.string "49", limit: 45
    t.string "50", limit: 45
    t.string "51", limit: 45
    t.string "52", limit: 45
    t.string "53", limit: 45
    t.string "54", limit: 45
    t.string "55", limit: 45
    t.string "56", limit: 45
    t.string "57", limit: 45
    t.string "58", limit: 45
    t.string "59", limit: 45
    t.string "60", limit: 45
    t.string "61", limit: 45
    t.string "62", limit: 45
    t.string "63", limit: 45
    t.string "64", limit: 45
    t.string "65", limit: 45
    t.string "66", limit: 45
    t.string "67", limit: 45
    t.string "68", limit: 45
    t.string "69", limit: 45
    t.string "70", limit: 45
    t.string "71", limit: 45
    t.string "72", limit: 45
    t.string "73", limit: 45
    t.string "74", limit: 45
    t.string "75", limit: 45
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "qualifications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "qdate"
    t.integer "leakdown"
    t.integer "qual_report_images_id"
    t.integer "alignment_report_images_id"
    t.integer "sixgas_report_images_id"
    t.integer "spectrum_report_images_id"
    t.integer "cylinder_compression_spec"
    t.integer "service_visit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cylinder_compression_tolerance"
  end

  create_table "referred_bies", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "description"
    t.boolean "is_other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salespeople", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_appointments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "date_time"
    t.datetime "actual_date_time"
    t.integer "status"
    t.integer "purpose"
    t.integer "vehicle_id"
    t.integer "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_service_items", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "scheduled_service_id"
    t.integer "service_description_id"
    t.string "other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_services", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_schedule_id"
    t.datetime "sdate"
    t.integer "mileage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_descriptions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "service_category_id"
    t.decimal "labor_rate_retail", precision: 8, scale: 2
    t.decimal "labor_hours_retail", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_journals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_visit_id"
    t.integer "event_id"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_journals_events", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_line_items", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_visit_id"
    t.integer "service_description_id"
    t.string "service_description_text"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "stype"
    t.integer "status"
    t.integer "service_category_id"
  end

  create_table "service_parts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_line_item_id"
    t.integer "part_id"
    t.decimal "part_retail_price", precision: 8, scale: 2
    t.decimal "part_actual_price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity", precision: 8, scale: 2
    t.integer "purchase_order_id"
  end

  create_table "service_schedules", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_visit_notes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_visit_id"
    t.integer "user_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_visits", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "mileage"
    t.datetime "sdate"
    t.string "description"
    t.integer "store_id"
    t.integer "vehicle_id"
    t.integer "invoice_id"
    t.integer "salesperson_id"
    t.text "comments"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "status"
    t.datetime "promised", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "location", default: 1
  end

  create_table "specialoffers", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.binary "img", limit: 4294967295, null: false
    t.string "link", limit: 500, null: false
  end

  create_table "states", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "abbrev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "number"
    t.integer "manager_id"
    t.string "street_address"
    t.string "city"
    t.integer "state_id"
    t.integer "county_id"
    t.integer "region_id"
    t.string "zip"
    t.string "phone"
    t.integer "number_of_lifts"
    t.integer "capacity"
    t.integer "break_even"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submodels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "make_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "technician_hours", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_line_item_id"
    t.decimal "labor_hours_retail", precision: 8, scale: 2
    t.decimal "labor_rate_retail", precision: 8, scale: 2
    t.decimal "labor_hours_actual", precision: 8, scale: 2
    t.decimal "labor_rate_actual", precision: 8, scale: 2
    t.integer "technician_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "technicians", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "employee_id"
    t.integer "level"
    t.decimal "hourly_rate", precision: 8, scale: 2
    t.integer "billed_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tire_td_readings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.datetime "tdate"
    t.integer "depth32nds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ts_band_recalls", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vehicle_id"
    t.string "name"
    t.datetime "date_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "upgrade_types", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.decimal "cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "added_miles"
  end

  create_table "upgrades", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "contract_id"
    t.integer "upgrade_type_id"
    t.decimal "cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "used_parts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Technician should enter the parts details he is using on a vehicle in this table." do |t|
    t.integer "store_id", null: false
    t.integer "vehicle_id", null: false
    t.integer "part_manufacturer_id", null: false
    t.integer "part_name_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["part_name_id"], name: "_idx"
    t.index ["part_name_id"], name: "part_name_id_idx"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "vin"
    t.string "vin_decoded"
    t.string "license_plate"
    t.integer "license_plate_state_id"
    t.integer "customer_id"
    t.integer "make_id"
    t.integer "model_id"
    t.integer "submodel_id"
    t.string "date_of_manufacture", limit: 10
    t.integer "country_of_manufacture_id"
    t.decimal "msrp", precision: 8, scale: 2
    t.decimal "kbb_on_qual", precision: 8, scale: 2
    t.decimal "current_kbb", precision: 8, scale: 2
    t.string "consumer_reports_url"
    t.integer "engine_cyl", default: 1
    t.integer "engine_displacement_id", default: 1
    t.integer "wheel_drive_id", default: 1
    t.integer "color_id", default: 1
    t.integer "doors"
    t.boolean "convertible"
    t.text "comments"
    t.integer "service_schedule_id"
    t.integer "insurance_company_id"
    t.string "insurance_policy_number"
    t.integer "insurance_image_id"
    t.string "carfax_url"
    t.string "carfax_copy_at_qual"
    t.integer "door_plate_image_id"
    t.integer "mileage", default: 100000
    t.decimal "mpg30after_initial", precision: 8, scale: 2, default: "120000.0"
    t.integer "photos_image_id"
    t.integer "qualification_id"
    t.boolean "bg_compliant"
    t.integer "contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ismember"
  end

  create_table "vendor_invoices", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "invoice_number"
    t.datetime "date_time"
    t.integer "vendor_id"
    t.integer "status"
    t.integer "purchase_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wheel_drives", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wp_commentmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "comment_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["comment_id"], name: "comment_id"
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
  end

  create_table "wp_comments", primary_key: "comment_ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "comment_post_ID", default: 0, null: false, unsigned: true
    t.text "comment_author", limit: 255, null: false
    t.string "comment_author_email", limit: 100, default: "", null: false
    t.string "comment_author_url", limit: 200, default: "", null: false
    t.string "comment_author_IP", limit: 100, default: "", null: false
    t.datetime "comment_date", null: false
    t.datetime "comment_date_gmt", null: false
    t.text "comment_content", null: false
    t.integer "comment_karma", default: 0, null: false
    t.string "comment_approved", limit: 20, default: "1", null: false
    t.string "comment_agent", default: "", null: false
    t.string "comment_type", limit: 20, default: "", null: false
    t.bigint "comment_parent", default: 0, null: false, unsigned: true
    t.bigint "user_id", default: 0, null: false, unsigned: true
    t.index ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt"
    t.index ["comment_author_email"], name: "comment_author_email", length: { comment_author_email: 10 }
    t.index ["comment_date_gmt"], name: "comment_date_gmt"
    t.index ["comment_parent"], name: "comment_parent"
    t.index ["comment_post_ID"], name: "comment_post_ID"
  end

  create_table "wp_links", primary_key: "link_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "link_url", default: "", null: false
    t.string "link_name", default: "", null: false
    t.string "link_image", default: "", null: false
    t.string "link_target", limit: 25, default: "", null: false
    t.string "link_description", default: "", null: false
    t.string "link_visible", limit: 20, default: "Y", null: false
    t.bigint "link_owner", default: 1, null: false, unsigned: true
    t.integer "link_rating", default: 0, null: false
    t.datetime "link_updated", null: false
    t.string "link_rel", default: "", null: false
    t.text "link_notes", limit: 16777215, null: false
    t.string "link_rss", default: "", null: false
    t.index ["link_visible"], name: "link_visible"
  end

  create_table "wp_options", primary_key: "option_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "option_name", limit: 191, default: "", null: false
    t.text "option_value", limit: 4294967295, null: false
    t.string "autoload", limit: 20, default: "yes", null: false
    t.index ["option_name"], name: "option_name", unique: true
  end

  create_table "wp_postmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "post_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
    t.index ["post_id"], name: "post_id"
  end

  create_table "wp_posts", primary_key: "ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "post_author", default: 0, null: false, unsigned: true
    t.datetime "post_date", null: false
    t.datetime "post_date_gmt", null: false
    t.text "post_content", limit: 4294967295, null: false
    t.text "post_title", null: false
    t.text "post_excerpt", null: false
    t.string "post_status", limit: 20, default: "publish", null: false
    t.string "comment_status", limit: 20, default: "open", null: false
    t.string "ping_status", limit: 20, default: "open", null: false
    t.string "post_password", default: "", null: false
    t.string "post_name", limit: 200, default: "", null: false
    t.text "to_ping", null: false
    t.text "pinged", null: false
    t.datetime "post_modified", null: false
    t.datetime "post_modified_gmt", null: false
    t.text "post_content_filtered", limit: 4294967295, null: false
    t.bigint "post_parent", default: 0, null: false, unsigned: true
    t.string "guid", default: "", null: false
    t.integer "menu_order", default: 0, null: false
    t.string "post_type", limit: 20, default: "post", null: false
    t.string "post_mime_type", limit: 100, default: "", null: false
    t.bigint "comment_count", default: 0, null: false
    t.index ["post_author"], name: "post_author"
    t.index ["post_name"], name: "post_name", length: { post_name: 191 }
    t.index ["post_parent"], name: "post_parent"
    t.index ["post_type", "post_status", "post_date", "ID"], name: "type_status_date"
  end

  create_table "wp_term_relationships", primary_key: ["object_id", "term_taxonomy_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "object_id", default: 0, null: false, unsigned: true
    t.bigint "term_taxonomy_id", default: 0, null: false, unsigned: true
    t.integer "term_order", default: 0, null: false
    t.index ["term_taxonomy_id"], name: "term_taxonomy_id"
  end

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "term_id", default: 0, null: false, unsigned: true
    t.string "taxonomy", limit: 32, default: "", null: false
    t.text "description", limit: 4294967295, null: false
    t.bigint "parent", default: 0, null: false, unsigned: true
    t.bigint "count", default: 0, null: false
    t.index ["taxonomy"], name: "taxonomy"
    t.index ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true
  end

  create_table "wp_termmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "term_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
    t.index ["term_id"], name: "term_id"
  end

  create_table "wp_terms", primary_key: "term_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name", limit: 200, default: "", null: false
    t.string "slug", limit: 200, default: "", null: false
    t.bigint "term_group", default: 0, null: false
    t.index ["name"], name: "name", length: { name: 191 }
    t.index ["slug"], name: "slug", length: { slug: 191 }
  end

  create_table "wp_usermeta", primary_key: "umeta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "user_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
    t.index ["user_id"], name: "user_id"
  end

  create_table "wp_users", primary_key: "ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "user_login", limit: 60, default: "", null: false
    t.string "user_pass", default: "", null: false
    t.string "user_nicename", limit: 50, default: "", null: false
    t.string "user_email", limit: 100, default: "", null: false
    t.string "user_url", limit: 100, default: "", null: false
    t.datetime "user_registered", null: false
    t.string "user_activation_key", default: "", null: false
    t.integer "user_status", default: 0, null: false
    t.string "display_name", limit: 250, default: "", null: false
    t.index ["user_email"], name: "user_email"
    t.index ["user_login"], name: "user_login_key"
    t.index ["user_nicename"], name: "user_nicename"
  end

  create_table "written_testimonies", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "user_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "parts", "part_names", name: "part_name_id"
  add_foreign_key "used_parts", "part_names", name: ""
end
