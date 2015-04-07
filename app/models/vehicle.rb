class Vehicle < ActiveRecord::Base
    attr_accessible :bg_compliant, :carfax_copy_at_qual, :carfax_url,
                    :color_id, :comments, :consumer_reports_url,
                    :contract_id, :convertible, :country_of_manufacture_id,
                    :current_kbb, :customer_id, :date_of_manufacture,
                    :door_plate_image_id, :doors, :engine_cyl,
                    :engine_displacement_id, :insurance_company_id,
                    :insurance_image_id, :insurance_policy_number,
                    :kbb_on_qual, :license_plate, :license_plate_state_id,
                    :make_id, :mileage, :model_id, :mpg30after_initial,
                    :msrp, :photos_image_id, :qualification_id,
                    :service_schedule_id, :submodel_id, :vin,
                    :vin_decoded, :wheel_drive_id

    belongs_to :color
    belongs_to :contract
    belongs_to :country_of_manufacture, class_name: :Country
    belongs_to :customer
    belongs_to :door_plate_image, class_name: :Image
    belongs_to :engine_displacement
    belongs_to :insurance_company
    belongs_to :insurance_image, class_name: :Image
    belongs_to :license_plate_state, class_name: :State
    belongs_to :make
    belongs_to :model
    belongs_to :submodel
    belongs_to :photos_imag, class_name: :Image
    belongs_to :qualification
    belongs_to :service_schedule
    belongs_to :wheel_drive

    has_many :service_visits
    has_many :scheduled_appointments
    has_many :gas_mileages
    has_many :non_ma_maintenances
    has_many :code_histories
    has_many :tire_td_readings
    has_many :bg_system_covereds
    has_many :breakdowns
    has_many :automatic_data_link_infos
    has_many :ts_band_recalls
    has_many :manufacturer_warranties

end
