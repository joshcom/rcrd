class IAmStupid < ActiveRecord::Migration
  def change
    drop_table :measures
  end
end
