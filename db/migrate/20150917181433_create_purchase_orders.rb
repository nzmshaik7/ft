class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.string :po_number
      t.integer :vendor_id
      t.datetime :date_time

      t.timestamps
    end
  end
end
