class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.integer :customer_id
      t.integer :paytype
      t.integer :priority
      t.integer :account_number_id
      t.string :routing_number
      t.integer :expiration_month
      t.integer :expiration_year
      t.integer :image_id

      t.timestamps
    end
  end
end
