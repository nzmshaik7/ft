class CreateScheduledAppointments < ActiveRecord::Migration
  def change
    create_table :scheduled_appointments do |t|
      t.datetime :date_time
      t.datetime :actual_date_time
      t.integer :status
      t.integer :purpose
      t.integer :vehicle_id
      t.integer :store_id

      t.timestamps
    end
  end
end
