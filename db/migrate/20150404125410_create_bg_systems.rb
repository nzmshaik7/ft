class CreateBgSystems < ActiveRecord::Migration
  def change
    create_table :bg_systems do |t|
      t.string :name

      t.timestamps
    end
  end
end
