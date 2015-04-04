class CreateSalespeople < ActiveRecord::Migration
  def change
    create_table :salespeople do |t|
      t.integer :employee_id

      t.timestamps
    end
  end
end
