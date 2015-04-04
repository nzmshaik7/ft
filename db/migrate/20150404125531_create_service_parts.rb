class CreateServiceParts < ActiveRecord::Migration
  def change
    create_table :service_parts do |t|
      t.integer :service_line_item_id
      t.integer :part_id
      t.decimal :part_retail_price, :precision => 8, :scale => 2
      t.decimal :part_actual_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
