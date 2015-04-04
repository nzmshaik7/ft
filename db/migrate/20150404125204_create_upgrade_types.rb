class CreateUpgradeTypes < ActiveRecord::Migration
  def change
    create_table :upgrade_types do |t|
      t.string :name
      t.decimal :cost, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
