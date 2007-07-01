class AddIndexViewIdScreen < ActiveRecord::Migration
  def self.up
    add_index :screens, :view_id
  end

  def self.down
    remove_index :screens, :view_id
  end
end
