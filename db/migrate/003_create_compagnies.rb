class CreateCompagnies < ActiveRecord::Migration
  def self.up
    create_table :compagnies do |t|
      t.column :name,     :string
      t.column :race_id,  :int
    end
  end

  def self.down
    drop_table :compagnies
  end
end
