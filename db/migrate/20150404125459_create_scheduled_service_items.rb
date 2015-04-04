class CreateScheduledServiceItems < ActiveRecord::Migration
  def change
    create_table :scheduled_service_items do |t|
      t.integer :scheduled_service_id
      t.integer :service_description_id
      t.string :other

      t.timestamps
    end
  end
end
