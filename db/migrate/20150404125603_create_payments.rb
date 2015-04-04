class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.datetime :date_time
      t.integer :invoice_id
      t.integer :contract_id
      t.integer :finance_agreement_id
      t.integer :customer_id
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :payment_method_id
      t.integer :status
      t.string :merchant_services_status
      t.string :comment

      t.timestamps
    end
  end
end
