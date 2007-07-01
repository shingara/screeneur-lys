class AddMessagePlayer < ActiveRecord::Migration
  def self.up
    add_column "players", "message", :string
  end

  def self.down
    remove_column "players", "message"
  end
end
