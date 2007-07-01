class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.column :lys_id,         :int
      t.column :name,           :string
      t.column :identification, :string
      t.column :compagny_id,    :int
      t.column :weapon_id,      :int
      t.column :level,          :int
      t.column :box_id,         :int
      t.column :race_id,        :int
    end
  end

  def self.down
    drop_table :players
  end
end
