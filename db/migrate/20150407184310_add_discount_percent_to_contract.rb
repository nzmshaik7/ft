class AddDiscountPercentToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :discount_percent, :integer
  end
end
