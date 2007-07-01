class AddCamouflagePlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :camouflage, :integer, :limit => 1
  end

  def self.down
    remove_column :players, :camouflage
  end
end
