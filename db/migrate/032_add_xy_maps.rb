class AddXyMaps < ActiveRecord::Migration
  def self.up
    add_column "maps", "x", :integer
    add_column "maps", "y", :integer
  end

  def self.down
    remove_column "maps", "x"
    remove_column "maps", "y"
  end
end
