class CreateManufacturerWarrantyTypes < ActiveRecord::Migration
  def change
    create_table :manufacturer_warranty_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
