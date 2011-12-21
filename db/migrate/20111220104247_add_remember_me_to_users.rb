class AddRememberMeToUsers < ActiveRecord::Migration
  def up
    add_column :users, :remember_me_token, :boolean, :default => false
  end

  def down
    remove_column :users, :remember_me_token, :boolean, :default => false
  end
end