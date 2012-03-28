class AddUserIdToMeasures < ActiveRecord::Migration
  def change
    add_column :measures, :user_id, :integer
  end
end
