class ChangeRecordNameType < ActiveRecord::Migration
  def change
    add_column :records, :raw, :text
  end
end
