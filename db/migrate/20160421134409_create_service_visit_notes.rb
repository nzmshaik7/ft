class CreateServiceVisitNotes < ActiveRecord::Migration
  def change
    create_table :service_visit_notes do |t|
      t.integer :service_visit_id
      t.integer :user_id
      t.text :note

      t.timestamps
    end
  end
end
