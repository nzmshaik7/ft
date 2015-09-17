class DeleteActualCostFromPart < ActiveRecord::Migration
  def up
    remove_column :parts, :actual_cost
  end

  def down
    add_column :parts, :actual_cost, :decimal, :precision => 8, :scale => 2
  end
end
