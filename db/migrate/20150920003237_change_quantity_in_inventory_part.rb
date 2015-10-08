class ChangeQuantityInInventoryPart < ActiveRecord::Migration
  def up
    change_column :inventory_parts, :quantity, :decimal, :precision => 8, 
                                                         :scale => 2
  end

  def down
    change_column :inventory_parts, :quantity, :integer
  end
end
