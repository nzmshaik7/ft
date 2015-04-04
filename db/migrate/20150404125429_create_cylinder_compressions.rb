class CreateCylinderCompressions < ActiveRecord::Migration
  def change
    create_table :cylinder_compressions do |t|
      t.integer :qualification_id
      t.integer :cyl_num
      t.integer :psi

      t.timestamps
    end
  end
end
