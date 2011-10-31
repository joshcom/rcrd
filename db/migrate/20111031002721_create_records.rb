class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.text :name

      t.timestamps
    end
  end
end
