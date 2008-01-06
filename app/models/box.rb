class Box < ActiveRecord::Base
  belongs_to :objet
  belongs_to :type
  belongs_to :map
  has_one :other

  belongs_to :player_1, :class_name => "Player", :foreign_key => "player_1_id"
  belongs_to :player_2, :class_name => "Player", :foreign_key => "player_2_id"
  belongs_to :player_3, :class_name => "Player", :foreign_key => "player_3_id"
  belongs_to :player_4, :class_name => "Player", :foreign_key => "player_4_id"

  def self.big_box x, y, step, map_id
    
    map = Map.find map_id

    x = 1 if x < 0
    y = 1 if y < 0
    x = map.x if x > map.x
    y = map.y if y > map.y

    all_x = [x]
    all_y = [y]


    step.times {|s|
      min_y = y - (s + 1)
      all_y << min_y unless min_y < 1

      max_y = y + (s + 1)
      all_y << max_y unless max_y > map.y

      min_x = x - (s + 1)
      all_x << min_x unless min_x < 1

      max_x = x + (s + 1)
      all_x << max_x unless max_x > map.x
    }

    all_y = all_y.sort
    box_y = {}
    all_y.each {|tmp_y|
      box_y[tmp_y] = Box.find(:all,
                              :conditions => ['x IN (?) AND y = ? AND map_id = ?', all_x, tmp_y, map_id],
                              :order => 'x,y ASC',
                              :include => [:type, :other])
    }
      [box_y, all_x.sort, all_y]
  end

  def player(user)
    @p ||= eval "player_#{user.player.race.id_lys}"
  end

  def updated_at(user)
    @d ||= eval "update_#{user.player.race.id_lys}"
  end

end
