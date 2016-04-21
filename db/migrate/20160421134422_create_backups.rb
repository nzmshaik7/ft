class CreateBackups < ActiveRecord::Migration
  def change
    create_table :backups do |t|
      t.string :table_name
      t.integer :user_id
      t.text :info

      t.timestamps
    end
  end
end
