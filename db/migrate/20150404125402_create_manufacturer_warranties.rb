class CreateManufacturerWarranties < ActiveRecord::Migration
  def change
    create_table :manufacturer_warranties do |t|
      t.integer :vehicle_id
      t.integer :months
      t.integer :miles
      t.integer :wtype
      t.integer :image
      t.string :comment

      t.timestamps
    end
  end
end
