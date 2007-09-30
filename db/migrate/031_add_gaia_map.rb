require 'insert_map'

class AddGaiaMap < ActiveRecord::Migration
  def self.up
    InsertMap.get 'Gaia', 'La cordillère de Gaia'
  end

  def self.down
    map = Map.find(:all, {:conditions => ['name = ?', 'La cordillère de Gaia']}).first
    Box.destroy_all ['map_id = ? ', map.id]
    map.destroy
  end
end
