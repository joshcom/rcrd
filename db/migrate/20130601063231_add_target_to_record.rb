class AddTargetToRecord < ActiveRecord::Migration
  def change
    add_column :records, :target, :datetime
  end
end
