class AddPicturePlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :picture, :string
  end

  def self.down
    remove_column :players, :picture
  end
end
