class CreateBreakdowns < ActiveRecord::Migration
  def change
    create_table :breakdowns do |t|
      t.integer :vehicle_id
      t.datetime :bdate
      t.text :description

      t.timestamps
    end
  end
end
