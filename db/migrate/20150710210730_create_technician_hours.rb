class CreateTechnicianHours < ActiveRecord::Migration
  def change
    create_table :technician_hours do |t|
      t.integer :service_line_item_id
      t.decimal :labor_hours_retail, :precision => 8, :scale => 2
      t.decimal :labor_rate_retail, :precision => 8, :scale => 2
      t.decimal :labor_hours_actual, :precision => 8, :scale => 2
      t.decimal :labor_rate_actual, :precision => 8, :scale => 2
      t.integer :technician_id

      t.timestamps
    end
  end
end
