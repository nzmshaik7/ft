class AddFirstNameToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :first_name, :string
  end
end
