class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.datetime :begin_date
      t.string :number
      t.integer :status
      t.integer :image_id
      t.integer :salesperson_id
      t.integer :level
      t.decimal :base_cost, :precision => 8, :scale => 2
      t.integer :day_of_payment
      t.decimal :discount, :precision => 8, :scale => 2
      t.integer :discount

      t.timestamps
    end
  end
end
