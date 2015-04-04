class CreateScheduledServices < ActiveRecord::Migration
  def change
    create_table :scheduled_services do |t|
      t.integer :service_schedule_id
      t.datetime :sdate
      t.integer :mileage

      t.timestamps
    end
  end
end
