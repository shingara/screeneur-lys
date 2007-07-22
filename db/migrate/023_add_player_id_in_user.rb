class AddPlayerIdInUser < ActiveRecord::Migration
  def self.up
    add_column :users, :player_id, :integer
  end

  def self.down
    remove_column :users, :player_id
  end
end
