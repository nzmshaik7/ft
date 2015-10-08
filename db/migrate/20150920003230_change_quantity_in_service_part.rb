class ChangeQuantityInServicePart < ActiveRecord::Migration
  def up
    change_column :service_parts, :quantity, :decimal, :precision => 8, 
                                                       :scale => 2
  end

  def down
    change_column :service_parts, :quantity, :integer
  end
end
