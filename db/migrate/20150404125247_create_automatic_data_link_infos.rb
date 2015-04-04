class CreateAutomaticDataLinkInfos < ActiveRecord::Migration
  def change
    create_table :automatic_data_link_infos do |t|
      t.integer :vehicle_id
      t.string :serial_number
      t.datetime :idate
      t.text :data

      t.timestamps
    end
  end
end
