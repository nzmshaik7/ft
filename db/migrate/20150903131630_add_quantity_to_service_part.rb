class AddQuantityToServicePart < ActiveRecord::Migration
  def change
    add_column :service_parts, :quantity, :integer
  end
end
