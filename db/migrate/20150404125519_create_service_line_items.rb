class CreateServiceLineItems < ActiveRecord::Migration
  def change
    create_table :service_line_items do |t|
      t.integer :service_visit_id
      t.integer :service_description_id
      t.string :service_description_text
      t.decimal :labor_hours_retail, :precision => 8, :scale => 2
      t.decimal :labor_rate_retail, :precision => 8, :scale => 2
      t.decimal :labor_hours_actual, :precision => 8, :scale => 2
      t.decimal :labor_rate_actual, :precision => 8, :scale => 2
      t.integer :technician1_id
      t.integer :technician2_id
      t.integer :technician3_id
      t.boolean :is_scheduled

      t.timestamps
    end
  end
end
