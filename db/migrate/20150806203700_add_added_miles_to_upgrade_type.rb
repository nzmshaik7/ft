class AddAddedMilesToUpgradeType < ActiveRecord::Migration
  def change
    add_column :upgrade_types, :added_miles, :integer
  end
end
