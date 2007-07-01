class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :types
  end
end
