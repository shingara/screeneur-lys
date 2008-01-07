class AddIndexBoxes < ActiveRecord::Migration
  def self.up
    add_index :boxes, :x
    add_index :boxes, :y
  end

  def self.down
    remove_index :boxes, :x
    remove_index :boxes, :y
  end
end
