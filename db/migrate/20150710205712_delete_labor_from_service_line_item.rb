class DeleteLaborFromServiceLineItem < ActiveRecord::Migration
  def up
    remove_column :service_line_items, :labor_hours_retail
    remove_column :service_line_items, :labor_rate_retail
    remove_column :service_line_items, :labor_hours_actual
    remove_column :service_line_items, :labor_rate_actual
    remove_column :service_line_items, :technician1_id
    remove_column :service_line_items, :technician2_id
    remove_column :service_line_items, :technician3_id
  end

  def down
    add_column :service_line_items, :labor_hours_retail, 'decimal{8.2}'
    add_column :service_line_items, :labor_rate_retail, 'decimal{8.2}'
    add_column :service_line_items, :labor_hours_actual, 'decimal{8.2}'
    add_column :service_line_items, :labor_rate_actual, 'decimal{8.2}'
    add_column :service_line_items, :technician1_id, :integer
    add_column :service_line_items, :technician2_id, :integer
    add_column :service_line_items, :technician3_id, :integer
  end
end
