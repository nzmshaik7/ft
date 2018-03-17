class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :store_id
      t.integer :part_id
      t.integer :count

      t.timestamps
    end
  end
end
