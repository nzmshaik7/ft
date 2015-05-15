class RenameManufacturerWarrantyColumn < ActiveRecord::Migration
    def change
        rename_column :manufacturer_warranties, :image, :image_id
    end
end
