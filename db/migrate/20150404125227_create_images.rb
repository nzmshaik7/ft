class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.integer :image_id

      t.timestamps
    end
  end
end
