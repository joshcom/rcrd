class ChangeKarmaPointsToDecmial < ActiveRecord::Migration
  def self.up
    change_column :karmas, :points, :decimal
  end

  def self.down
    change_column :karmas, :points, :decimal
  end
end
