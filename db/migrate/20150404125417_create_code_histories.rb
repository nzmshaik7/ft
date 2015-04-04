class CreateCodeHistories < ActiveRecord::Migration
  def change
    create_table :code_histories do |t|
      t.integer :vehicle_id
      t.datetime :cdate
      t.string :code

      t.timestamps
    end
  end
end
