class AddPurchaseOrderIdToServicePart < ActiveRecord::Migration
  def change
    add_column :service_parts, :purchase_order_id, :integer
  end
end
