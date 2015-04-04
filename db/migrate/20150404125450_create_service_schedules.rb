class CreateServiceSchedules < ActiveRecord::Migration
  def change
    create_table :service_schedules do |t|
      t.integer :image_id

      t.timestamps
    end
  end
end
