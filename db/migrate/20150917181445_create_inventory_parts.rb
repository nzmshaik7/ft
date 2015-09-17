class CreateInventoryParts < ActiveRecord::Migration
  def change
    create_table :inventory_parts do |t|
      t.integer :purchase_order_id
      t.integer :part_id
      t.integer :quantity
      t.decimal :part_actual_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
