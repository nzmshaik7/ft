class CreateTechnicians < ActiveRecord::Migration
  def change
    create_table :technicians do |t|
      t.integer :employee_id
      t.integer :level
      t.decimal :hourly_rate, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
