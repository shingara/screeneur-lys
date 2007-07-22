class AddMapBase < ActiveRecord::Migration
  def self.up
    Map.create(:name => 'NoisRevii')
    Map.create(:name => 'Le fleuve Tetovo')
  end

  def self.down
    Map.destroy_all ['name IN (?,?)', 'NoisRevii', 'Debutant', 'Le fleuve Tetovo']
  end
end
