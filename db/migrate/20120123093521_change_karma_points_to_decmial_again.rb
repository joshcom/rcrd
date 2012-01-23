class ChangeKarmaPointsToDecmialAgain < ActiveRecord::Migration
  def self.up
    change_column :karmas, :points, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :karmas, :points, :decimal
  end
end
