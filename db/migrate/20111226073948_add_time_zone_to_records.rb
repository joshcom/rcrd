class AddTimeZoneToRecords < ActiveRecord::Migration
  def self.up
    add_column :records, :time_zone, :string
  end
  
  def self.down
    remove_column :records, :time_zone
  end
end
