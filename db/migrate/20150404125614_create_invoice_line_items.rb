class CreateInvoiceLineItems < ActiveRecord::Migration
  def change
    create_table :invoice_line_items do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :invoice_id
      t.integer :line_item_purpose_id
      t.string :description
      t.integer :service_visit_id
      t.integer :vehicle_id

      t.timestamps
    end
  end
end
