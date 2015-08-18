class AddStatusToServiceVisit < ActiveRecord::Migration
  def change
    add_column :service_visits, :status, :integer
  end
end
