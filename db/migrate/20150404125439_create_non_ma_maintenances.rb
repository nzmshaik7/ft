class CreateNonMaMaintenances < ActiveRecord::Migration
  def change
    create_table :non_ma_maintenances do |t|
      t.integer :vehicle_id
      t.datetime :mdate
      t.string :where
      t.integer :document_image_id

      t.timestamps
    end
  end
end
