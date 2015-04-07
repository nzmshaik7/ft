class DeletePaytypeFromPaymentMethod < ActiveRecord::Migration
  def up
    remove_column :payment_methods, :paytype
  end

  def down
    add_column :payment_methods, :paytype, :integer
  end
end
