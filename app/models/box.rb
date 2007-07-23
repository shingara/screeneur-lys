class Box < ActiveRecord::Base
  belongs_to :player
  belongs_to :type
  belongs_to :map

  def self.big_box x, y, step
    all_x = [x]
    all_y = [y]
    step.times {|s|
      all_y << y - (s + 1)
      all_y << y + (s + 1)
      all_x << x + (s + 1)
      all_x << x - (s + 1)
    }

    all_y = all_y.sort
    box_y = {}
    all_y.each {|tmp_y|
      box_y[tmp_y] = Box.find(:all,
                              :conditions => ['x IN (?) AND y = ?', all_x, tmp_y],
                              :order => 'x,y ASC')
    }
      [box_y, all_x.sort, all_y]
  end
end
