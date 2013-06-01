class CleanUp < ActiveRecord::Migration
  def change 
    drop_table :categories
    drop_table :cats
    drop_table :cats_records
    drop_table :evil_wizards
    drop_table :karmas
    drop_table :sorcerers
    drop_table :wizards
    remove_index('users', :name => "index_users_on_remember_me_token")
  end
end
