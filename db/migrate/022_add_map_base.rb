class AddMapBase < ActiveRecord::Migration
  def self.up
    Map.create(:name => 'NoisRevii')
    Map.create(:name => 'Debutant')
  end

  def self.down
    Map.destroy_all ['name IN (?,?)', 'NoisRevii', 'Debutant']
  end
end
