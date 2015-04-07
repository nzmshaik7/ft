class AddPaymentTypeIdToPaymentMethod < ActiveRecord::Migration
  def change
    add_column :payment_methods, :payment_type_id, :integer
  end
end
