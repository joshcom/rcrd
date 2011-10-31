class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.text :name
      t.integer :value

      t.timestamps
    end
  end
end
