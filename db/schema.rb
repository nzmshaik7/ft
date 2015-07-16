# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150710210730) do

  create_table "automatic_data_link_infos", :force => true do |t|
    t.integer  "vehicle_id"
    t.string   "serial_number"
    t.datetime "idate"
    t.text     "data"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "bg_system_covereds", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "system_id"
    t.integer  "coverage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bg_systems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "breakdowns", :force => true do |t|
    t.integer  "vehicle_id"
    t.datetime "bdate"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "code_histories", :force => true do |t|
    t.integer  "vehicle_id"
    t.datetime "cdate"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contracts", :force => true do |t|
    t.datetime "begin_date"
    t.string   "number"
    t.integer  "status"
    t.integer  "image_id"
    t.integer  "salesperson_id"
    t.integer  "level"
    t.decimal  "base_cost",        :precision => 8,  :scale => 2
    t.integer  "day_of_payment"
    t.decimal  "discount",         :precision => 10, :scale => 0
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "discount_percent"
  end

  create_table "counties", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "cid"
    t.integer  "user_id"
    t.string   "street_addr1"
    t.string   "street_addr2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip"
    t.string   "home_phone"
    t.boolean  "can_text_home_phone"
    t.string   "work_phone"
    t.boolean  "can_text_work_phone"
    t.string   "mobile_phone"
    t.boolean  "can_text_mobile_phone"
    t.string   "other_phone"
    t.boolean  "can_text_other_phone"
    t.datetime "joined_date"
    t.boolean  "is_aaa_member"
    t.boolean  "is_web_registered"
    t.string   "spouse_name"
    t.integer  "spouse_id"
    t.integer  "signup_store_id"
    t.integer  "referredBy_id"
    t.integer  "referredBy_customer_id"
    t.string   "referredBy_other_text"
    t.string   "ssn"
    t.string   "driver_lic_num"
    t.integer  "driver_lic_state_id"
    t.integer  "driver_lic_image_id"
    t.datetime "date_of_birth"
    t.integer  "gender"
    t.string   "video_testimony_url"
    t.integer  "written_testimony_id"
    t.integer  "referral_credits_earned"
    t.integer  "referral_credits_used"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "contact_method"
  end

  create_table "cylinder_compressions", :force => true do |t|
    t.integer  "qualification_id"
    t.integer  "cyl_num"
    t.integer  "psi"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "ssn"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "engine_displacements", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "finance_agreements", :force => true do |t|
    t.integer  "customer_id"
    t.decimal  "missed_payment_fee",     :precision => 8, :scale => 2
    t.decimal  "total_principal",        :precision => 8, :scale => 2
    t.decimal  "finance_fee",            :precision => 8, :scale => 2
    t.decimal  "monthly_payment_amount", :precision => 8, :scale => 2
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "title_image_id"
    t.integer  "agreement_image_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  create_table "gas_mileages", :force => true do |t|
    t.integer  "vehicle_id"
    t.decimal  "mileage",    :precision => 8, :scale => 2
    t.datetime "mdate"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "filename"
    t.integer  "image_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "insurance_companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inventories", :force => true do |t|
    t.integer  "store_id"
    t.integer  "part_id"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invoice_line_items", :force => true do |t|
    t.decimal  "amount",               :precision => 8, :scale => 2
    t.integer  "invoice_id"
    t.integer  "line_item_purpose_id"
    t.string   "description"
    t.integer  "service_visit_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  create_table "invoices", :force => true do |t|
    t.string   "invoice_number"
    t.datetime "date_time"
    t.integer  "customer_id"
    t.integer  "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "line_item_purposes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "makes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "manufacturer_warranties", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "months"
    t.integer  "miles"
    t.integer  "image_id"
    t.string   "comment"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "manufacturer_warranty_type_id"
  end

  create_table "manufacturer_warranty_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "models", :force => true do |t|
    t.string   "name"
    t.integer  "make_id"
    t.integer  "first_year_made"
    t.integer  "last_year_made"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "non_ma_maintenances", :force => true do |t|
    t.integer  "vehicle_id"
    t.datetime "mdate"
    t.string   "where"
    t.integer  "document_image_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "part_manufacturers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "part_names", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parts", :force => true do |t|
    t.integer  "part_manufacturer_id"
    t.integer  "part_name_id"
    t.string   "description"
    t.string   "part_number"
    t.decimal  "actual_cost",          :precision => 8, :scale => 2
    t.decimal  "retail_price",         :precision => 8, :scale => 2
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  create_table "payment_methods", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "priority"
    t.integer  "account_number_id"
    t.string   "routing_number"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.integer  "image_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "payment_type_id"
  end

  create_table "payment_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.datetime "date_time"
    t.integer  "invoice_id"
    t.integer  "contract_id"
    t.integer  "finance_agreement_id"
    t.integer  "customer_id"
    t.decimal  "amount",                   :precision => 8, :scale => 2
    t.integer  "payment_method_id"
    t.integer  "status"
    t.string   "merchant_services_status"
    t.string   "comment"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  create_table "qualifications", :force => true do |t|
    t.datetime "qdate"
    t.integer  "leakdown"
    t.integer  "qual_report_images_id"
    t.integer  "alignment_report_images_id"
    t.integer  "sixgas_report_images_id"
    t.integer  "spectrum_report_images_id"
    t.integer  "cylinder_compression_spec"
    t.integer  "service_visit_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "cylinder_compression_tolerance"
  end

  create_table "referred_bies", :force => true do |t|
    t.string   "description"
    t.boolean  "is_other"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "salespeople", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "scheduled_appointments", :force => true do |t|
    t.datetime "date_time"
    t.datetime "actual_date_time"
    t.integer  "status"
    t.integer  "purpose"
    t.integer  "vehicle_id"
    t.integer  "store_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "scheduled_service_items", :force => true do |t|
    t.integer  "scheduled_service_id"
    t.integer  "service_description_id"
    t.string   "other"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "scheduled_services", :force => true do |t|
    t.integer  "service_schedule_id"
    t.datetime "sdate"
    t.integer  "mileage"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "service_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "service_descriptions", :force => true do |t|
    t.string   "name"
    t.integer  "service_category_id"
    t.decimal  "labor_rate_retail",   :precision => 8, :scale => 2
    t.decimal  "labor_hours_retail",  :precision => 8, :scale => 2
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "service_journals", :force => true do |t|
    t.integer  "service_visit_id"
    t.integer  "event_id"
    t.datetime "date_time"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "service_journals_events", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "service_line_items", :force => true do |t|
    t.integer  "service_visit_id"
    t.integer  "service_description_id"
    t.string   "service_description_text"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "stype"
  end

  create_table "service_parts", :force => true do |t|
    t.integer  "service_line_item_id"
    t.integer  "part_id"
    t.decimal  "part_retail_price",    :precision => 8, :scale => 2
    t.decimal  "part_actual_price",    :precision => 8, :scale => 2
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  create_table "service_schedules", :force => true do |t|
    t.integer  "image_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "service_visits", :force => true do |t|
    t.integer  "mileage"
    t.datetime "sdate"
    t.string   "description"
    t.integer  "store_id"
    t.integer  "vehicle_id"
    t.integer  "invoice_id"
    t.integer  "salesperson_id"
    t.text     "comments"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "manager_id"
    t.string   "street_address"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "county_id"
    t.integer  "region_id"
    t.string   "zip"
    t.string   "phone"
    t.integer  "number_of_lifts"
    t.integer  "capacity"
    t.integer  "break_even"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "submodels", :force => true do |t|
    t.string   "name"
    t.integer  "make_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "technician_hours", :force => true do |t|
    t.integer  "service_line_item_id"
    t.decimal  "labor_hours_retail",   :precision => 8, :scale => 2
    t.decimal  "labor_rate_retail",    :precision => 8, :scale => 2
    t.decimal  "labor_hours_actual",   :precision => 8, :scale => 2
    t.decimal  "labor_rate_actual",    :precision => 8, :scale => 2
    t.integer  "technician_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  create_table "technicians", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "level"
    t.decimal  "hourly_rate", :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "tire_td_readings", :force => true do |t|
    t.integer  "vehicle_id"
    t.datetime "tdate"
    t.integer  "depth32nds"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ts_band_recalls", :force => true do |t|
    t.integer  "vehicle_id"
    t.string   "name"
    t.datetime "date_completed"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "upgrade_types", :force => true do |t|
    t.string   "name"
    t.decimal  "cost",       :precision => 8, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "upgrades", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "upgrade_type_id"
    t.decimal  "cost",            :precision => 8, :scale => 2
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "role"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vehicles", :force => true do |t|
    t.string   "vin"
    t.string   "vin_decoded"
    t.string   "license_plate"
    t.integer  "license_plate_state_id"
    t.integer  "customer_id"
    t.integer  "make_id"
    t.integer  "model_id"
    t.integer  "submodel_id"
    t.datetime "date_of_manufacture"
    t.integer  "country_of_manufacture_id"
    t.decimal  "msrp",                      :precision => 8, :scale => 2
    t.decimal  "kbb_on_qual",               :precision => 8, :scale => 2
    t.decimal  "current_kbb",               :precision => 8, :scale => 2
    t.string   "consumer_reports_url"
    t.integer  "engine_cyl"
    t.integer  "engine_displacement_id"
    t.integer  "wheel_drive_id"
    t.integer  "color_id"
    t.integer  "doors"
    t.boolean  "convertible"
    t.text     "comments"
    t.integer  "service_schedule_id"
    t.integer  "insurance_company_id"
    t.string   "insurance_policy_number"
    t.integer  "insurance_image_id"
    t.string   "carfax_url"
    t.string   "carfax_copy_at_qual"
    t.integer  "door_plate_image_id"
    t.integer  "mileage"
    t.decimal  "mpg30after_initial",        :precision => 8, :scale => 2
    t.integer  "photos_image_id"
    t.integer  "qualification_id"
    t.boolean  "bg_compliant"
    t.integer  "contract_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  create_table "wheel_drives", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "written_testimonies", :force => true do |t|
    t.text     "user_text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
