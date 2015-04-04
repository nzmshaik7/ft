class CreateServiceJournalsEvents < ActiveRecord::Migration
  def change
    create_table :service_journals_events do |t|
      t.string :name

      t.timestamps
    end
  end
end
