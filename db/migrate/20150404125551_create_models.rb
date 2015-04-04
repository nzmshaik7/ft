class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.integer :make_id
      t.integer :first_year_made
      t.integer :last_year_made

      t.timestamps
    end
  end
end
