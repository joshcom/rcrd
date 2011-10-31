class AddRecordIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :record_id, :integer
  end
end
