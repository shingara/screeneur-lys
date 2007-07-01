class AddPlayerIdBox < ActiveRecord::Migration
  def self.up
    add_column :boxes, :player_id, :integer
  end

  def self.down
    remove_column :boxes, :player_id
  end
end
