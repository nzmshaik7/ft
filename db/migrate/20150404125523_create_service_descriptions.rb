class CreateServiceDescriptions < ActiveRecord::Migration
  def change
    create_table :service_descriptions do |t|
      t.string :name
      t.integer :service_category_id
      t.decimal :labor_rate_retail, :precision => 8, :scale => 2
      t.decimal :labor_hours_retail, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
