class DefineRace < ActiveRecord::Migration
  def self.up

    add_column "races", "id_lys", :integer
    
    r_terrien = Race.find_or_initialize_by_abbreviation 'T'
    r_terrien.name = 'Terrien'
    r_terrien.id_lys = 1
    r_terrien.save

    r_lysien = Race.find_or_initialize_by_abbreviation 'L'
    r_lysien.name = 'Lysien'
    r_lysien.id_lys = 2
    r_lysien.save
    
    r_eagle = Race.find_or_initialize_by_abbreviation 'E'
    r_eagle.name = 'Eagle'
    r_eagle.id_lys = 3
    r_eagle.save
    
    r_aaks = Race.find_or_initialize_by_abbreviation 'A'
    r_aaks.name = 'Aaks'
    r_aaks.id_lys = 4
    r_aaks.save
  end

  def self.down
    remove_column "races", "id_lys"
  end
end
