class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :number
      t.integer :manager_id
      t.string :street_address
      t.string :city
      t.integer :state_id
      t.integer :county_id
      t.integer :region_id
      t.string :zip
      t.string :phone
      t.integer :number_of_lifts
      t.integer :capacity
      t.integer :break_even

      t.timestamps
    end
  end
end
