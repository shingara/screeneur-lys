class CreateObjets < ActiveRecord::Migration
  def self.up
    create_table :objets do |t|
      t.column :name, :string
      t.column :box_id, :int
      t.column :lys_id, :string
      t.column :picture, :string
    end
  end

  def self.down
    drop_table :objets
  end
end
