class CreateUpgrades < ActiveRecord::Migration
  def change
    create_table :upgrades do |t|
      t.integer :contract_id
      t.integer :upgrade_type_id
      t.decimal :cost, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
