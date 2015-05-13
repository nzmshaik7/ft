class DeleteIsScheduledFromServiceLineItem < ActiveRecord::Migration
  def up
    remove_column :service_line_items, :is_scheduled
  end

  def down
    add_column :service_line_items, :is_scheduled, :tinyint
  end
end
