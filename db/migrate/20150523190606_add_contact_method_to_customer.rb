class AddContactMethodToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :contact_method, :integer
  end
end
