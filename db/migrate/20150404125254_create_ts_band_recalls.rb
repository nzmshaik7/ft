class CreateTsBandRecalls < ActiveRecord::Migration
  def change
    create_table :ts_band_recalls do |t|
      t.integer :vehicle_id
      t.string :name
      t.datetime :date_completed

      t.timestamps
    end
  end
end
