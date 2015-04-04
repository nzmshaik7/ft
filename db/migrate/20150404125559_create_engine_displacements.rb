class CreateEngineDisplacements < ActiveRecord::Migration
  def change
    create_table :engine_displacements do |t|
      t.string :name

      t.timestamps
    end
  end
end
