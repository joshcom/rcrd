class AddUserIdToKarmas < ActiveRecord::Migration
  def change
    add_column :karmas, :user_id, :integer
  end
end
