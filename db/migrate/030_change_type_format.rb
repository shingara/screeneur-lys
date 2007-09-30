class ChangeTypeFormat < ActiveRecord::Migration
  def self.up
    add_column(:types, :path, :string , {:limit => 50})
    add_column(:types, :font_map, :string , {:limit => 10})
    
    Type.create!({:name => 'plaine',
      :font_map => '#4aff50',
      :path => 'image/deco/plaine.gif'
    })
    Type.create!({
      :name => 'montagne',
      :font_map => '#66543c',
      :path => 'image/deco/montagne.jpeg'
    })

    Type.create!({
      :name => 'foret',
      :font_map => '#4aba00',
      :path => 'image/deco/foret.jpeg'
    })

    Type.create!({
      :name => 'desert',
      :font_map => '#ffff00',
      :path => 'image/deco/desert.jpeg'
    })

    Type.create!({
      :name => 'lysepice',
      :font_map => '#90a0c0',
      :path => 'image/deco/lysepice.gif'
    })

    Type.create!({
      :name => 'riviere',
      :font_map => '#01c6ff',
      :path => 'image/deco/eau.jpg'
    })

    Type.create!({
      :name => 'pont',
      :font_map => '#404040',
      :path => 'image/deco/pont.jpeg'
    })

    Type.create!({
      :name => 'neige',
      :font_map => '#d8f2f2',
      :path => 'image/deco/neige.jpeg'
    })
    Type.create!({
      :name => 'lave',
      :font_map => '#ffbc97',
      :path => 'image/deco/lave.jpg'
    })

    Type.create!({
      :name => 'taiga',
      :font_map => '#a6e6a6',
      :path => 'image/deco/taiga.jpg'
    })

    Type.create!({
      :name => 'bayou',
      :font_map => '#ae7a96',
      :path => 'image/deco/bayou.jpg'
    })

    Type.create!({
      :name => 'jungle',
      :font_map => '#1b771b',
      :path => 'image/deco/jungle.jpg'
    })

    Type.create!({
      :name => 'plateau',
      :font_map => '#988c04',
      :path => 'image/deco/plateau.jpg'
    })

    Type.create!({
      :name => 'savane',
      :font_map => '#d5c87b',
      :path => 'image/deco/savane.jpg'
    })

    Type.create!({
      :name => 'ruine',
      :font_map => '#efcbe5',
      :path => 'image/deco/ruine.jpg'
    })

  end

  def self.down
    remove_column :types, :path
    remove_column :types, :font_map
  end
end
