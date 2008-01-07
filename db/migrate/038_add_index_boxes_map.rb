class AddIndexBoxesMap < ActiveRecord::Migration
  def self.up
    add_index :boxes, :map_id
  end

  def self.down
    remove_index :boxes, :map_id
  end
end
