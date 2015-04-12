class DeleteWtypeFromManufacturerWarranty < ActiveRecord::Migration
  def up
    remove_column :manufacturer_warranties, :wtype
  end

  def down
    add_column :manufacturer_warranties, :wtype, :integer
  end
end
