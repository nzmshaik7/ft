class CreateTireTdReadings < ActiveRecord::Migration
  def change
    create_table :tire_td_readings do |t|
      t.integer :vehicle_id
      t.datetime :tdate
      t.integer :depth32nds

      t.timestamps
    end
  end
end
