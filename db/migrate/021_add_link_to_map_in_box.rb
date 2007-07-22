class AddLinkToMapInBox < ActiveRecord::Migration
  def self.up
    add_column :boxes, :map_id, :integer
  end

  def self.down
    remove_column :boxes, :map_id
  end
end
