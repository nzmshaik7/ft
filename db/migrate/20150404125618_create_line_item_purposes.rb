class CreateLineItemPurposes < ActiveRecord::Migration
  def change
    create_table :line_item_purposes do |t|
      t.string :name

      t.timestamps
    end
  end
end
