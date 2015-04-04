class CreateBgSystemCovereds < ActiveRecord::Migration
  def change
    create_table :bg_system_covereds do |t|
      t.integer :vehicle_id
      t.integer :system_id
      t.integer :coverage

      t.timestamps
    end
  end
end
