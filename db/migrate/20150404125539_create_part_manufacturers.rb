class CreatePartManufacturers < ActiveRecord::Migration
  def change
    create_table :part_manufacturers do |t|
      t.string :name

      t.timestamps
    end
  end
end
