class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :part_manufacturer_id
      t.integer :part_name_id
      t.string :description
      t.string :part_number
      t.decimal :actual_cost, :precision => 8, :scale => 2
      t.decimal :retail_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
