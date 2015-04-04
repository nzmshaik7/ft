class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :ssn
      t.integer :store_id

      t.timestamps
    end
  end
end
