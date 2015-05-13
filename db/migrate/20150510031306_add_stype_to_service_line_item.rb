class AddStypeToServiceLineItem < ActiveRecord::Migration
  def change
    add_column :service_line_items, :stype, :integer
  end
end
