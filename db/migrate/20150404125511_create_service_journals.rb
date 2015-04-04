class CreateServiceJournals < ActiveRecord::Migration
  def change
    create_table :service_journals do |t|
      t.integer :service_visit_id
      t.integer :event_id
      t.datetime :date_time

      t.timestamps
    end
  end
end
