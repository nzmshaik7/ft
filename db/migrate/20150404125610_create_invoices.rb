class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.datetime :date_time
      t.integer :customer_id
      t.integer :status

      t.timestamps
    end
  end
end
