class CreateWheelDrives < ActiveRecord::Migration
  def change
    create_table :wheel_drives do |t|
      t.string :name

      t.timestamps
    end
  end
end
