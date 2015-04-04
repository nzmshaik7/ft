class CreatePartNames < ActiveRecord::Migration
  def change
    create_table :part_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
