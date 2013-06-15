class CreateRecords < ActiveRecord::Migration
  def change
   create_table :records do |t|
      t.text     :name
      t.text     :raw
      t.integer  :user_id
      t.datetime :target
      t.timestamps
    end
  end
end
