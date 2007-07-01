class AddIndexToIndentification < ActiveRecord::Migration
  def self.up
    add_index "players", "lys_id"
  end

  def self.down
    remove_index "players", "lys_id"
  end
end
