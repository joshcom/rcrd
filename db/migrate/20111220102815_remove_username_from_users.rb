class RemoveUsernameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :username, :string
  end

  def down
    add_column :users, :username, :string
  end
end
