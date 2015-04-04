class CreateGasMileages < ActiveRecord::Migration
  def change
    create_table :gas_mileages do |t|
      t.integer :vehicle_id
      t.decimal :mileage, :precision => 8, :scale => 2
      t.datetime :mdate

      t.timestamps
    end
  end
end
