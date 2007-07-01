class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.column :x, :int
      t.column :y, :int
      t.column :type_id, :int
      t.column :updated_at, :date
      t.column :race_id, :int
      t.column :user_id, :int
    end
  end

  def self.down
    drop_table :boxes
  end
end
