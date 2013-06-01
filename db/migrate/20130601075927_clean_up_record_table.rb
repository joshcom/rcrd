class CleanUpRecordTable < ActiveRecord::Migration
  def change 
    remove_column :records, :record_id
    remove_column :records, :time_zone
  end
end
