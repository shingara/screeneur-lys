class ChangePathPlaine < ActiveRecord::Migration
  def self.up
    t = Type.find_by_name 'plaine'
    t.path = 'image/deco/plaine.jpeg'
    t.font_color = '#fffff'
    t.save

    t = Type.find_by_name 'pont'
    t.font_color = '#FFFFFF'
    t.save

    t = Type.find_by_name 'bayou'
    t.font_color = '#000000'
    t.save

    t = Type.find_by_name 'neige'
    t.font_color = '#000000'
    t.save
    
    t = Type.find_by_name 'savane'
    t.font_color = '#FFFFFF'
    t.save

    t = Type.find_by_name 'desert'
    t.font_color = '#000000'
    t.save

    t = Type.find_by_name 'jungle'
    t.font_color = '#FFFFFF'
    t.save
    
    t = Type.find_by_name 'ruine'
    t.font_color = '#ffffff'
    t.save

    t = Type.find_by_name 'taiga'
    t.font_color = '#00000'
    t.save
    
    t = Type.find_by_name 'foret'
    t.font_color = '#ffffff'
    t.save

    t = Type.find_by_name 'montagne'
    t.font_color = '#ffffff'
    t.save
    
    t = Type.find_by_name 'plateau'
    t.font_color = '#ffffff'
    t.save
  end

  def self.down
    t = Type.find_by_name 'plaine'
    t.path = 'image/deco/plaine.gif'
    t.save
  end
end
