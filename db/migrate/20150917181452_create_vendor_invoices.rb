class CreateVendorInvoices < ActiveRecord::Migration
  def change
    create_table :vendor_invoices do |t|
      t.string :invoice_number
      t.datetime :date_time
      t.integer :vendor_id
      t.integer :status
      t.integer :purchase_order_id

      t.timestamps
    end
  end
end
