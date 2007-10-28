class AddRaceScreen < ActiveRecord::Migration
  def self.up
    add_column "screens", "race_id", :integer
  end

  def self.down
    remove_column "screens", "race_id"
  end
end
