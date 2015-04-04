class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :vin
      t.string :vin_decoded
      t.string :license_plate
      t.integer :license_plate_state_id
      t.integer :customer_id
      t.integer :make_id
      t.integer :model_id
      t.integer :submodel_id
      t.datetime :date_of_manufacture
      t.integer :country_of_manufacture_id
      t.decimal :msrp, :precision => 8, :scale => 2
      t.decimal :kbb_on_qual, :precision => 8, :scale => 2
      t.decimal :current_kbb, :precision => 8, :scale => 2
      t.string :consumer_reports_url
      t.integer :engine_cyl
      t.integer :engine_displacement_id
      t.integer :wheel_drive_id
      t.integer :color_id
      t.integer :doors
      t.boolean :convertible
      t.text :comments
      t.integer :service_schedule_id
      t.integer :insurance_company_id
      t.string :insurance_policy_number
      t.integer :insurance_image_id
      t.string :carfax_url
      t.string :carfax_copy_at_qual
      t.integer :door_plate_image_id
      t.integer :mileage
      t.decimal :mpg30after_initial, :precision => 8, :scale => 2
      t.integer :photos_image_id
      t.integer :qualification_id
      t.boolean :bg_compliant
      t.integer :contract_id

      t.timestamps
    end
  end
end
