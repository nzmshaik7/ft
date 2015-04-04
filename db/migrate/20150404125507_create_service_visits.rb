class CreateServiceVisits < ActiveRecord::Migration
  def change
    create_table :service_visits do |t|
      t.integer :mileage
      t.datetime :sdate
      t.string :description
      t.integer :store_id
      t.integer :vehicle_id
      t.integer :invoice_id
      t.integer :salesperson_id
      t.text :comments

      t.timestamps
    end
  end
end
