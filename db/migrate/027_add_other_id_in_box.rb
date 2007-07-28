class AddOtherIdInBox < ActiveRecord::Migration
  def self.up
    add_column :boxes, :other_id, :integer
  end

  def self.down
    remove_column :boxes, :other_id
  end
end
