class AddGradePlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :grade_id, :integer
  end

  def self.down
    remove_column :players, :grade_id
  end
end
