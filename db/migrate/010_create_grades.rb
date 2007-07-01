class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.column :name, :string
      t.column :race_id, :int
    end
  end

  def self.down
    drop_table :grades
  end
end
