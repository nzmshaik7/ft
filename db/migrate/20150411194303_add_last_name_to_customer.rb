class AddLastNameToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :last_name, :string
  end
end
