class AddMapThird < ActiveRecord::Migration
  def self.up
    Map.create(:name => 'Les bations abandonn')
  end

  def self.down
    Map.destroy_all ['name = ?', 'Les bations abandonn']
  end
end
