class CreateReferredBies < ActiveRecord::Migration
  def change
    create_table :referred_bies do |t|
      t.string :description
      t.boolean :is_other

      t.timestamps
    end
  end
end
