class AddManufacturerWarrantyTypeIdToManufacturerWarranty < ActiveRecord::Migration
  def change
    add_column :manufacturer_warranties, :manufacturer_warranty_type_id, :integer
  end
end
