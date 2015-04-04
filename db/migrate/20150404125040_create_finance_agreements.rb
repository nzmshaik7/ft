class CreateFinanceAgreements < ActiveRecord::Migration
  def change
    create_table :finance_agreements do |t|
      t.integer :customer_id
      t.decimal :missed_payment_fee, :precision => 8, :scale => 2
      t.decimal :total_principal, :precision => 8, :scale => 2
      t.decimal :finance_fee, :precision => 8, :scale => 2
      t.decimal :monthly_payment_amount, :precision => 8, :scale => 2
      t.datetime :start_date
      t.datetime :end_date
      t.integer :title_image_id
      t.integer :agreement_image_id

      t.timestamps
    end
  end
end
