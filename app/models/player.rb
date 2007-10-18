class Player < ActiveRecord::Base
  include DownloadPicture

  has_one :box1, :class_name => "Box", :foreign_key => "player_1_id"
  has_one :box2, :class_name => "Box", :foreign_key => "player_2_id"
  has_one :box3, :class_name => "Box", :foreign_key => "player_3_id"
  has_one :box4, :class_name => "Box", :foreign_key => "player_4_id"

  belongs_to :compagny
  belongs_to :grade
  belongs_to :weapon
  belongs_to :race
  
  validates_uniqueness_of :identification
  
  def after_save
    check_picture_exist picture
  end

  #Return the box save by race of player
  def box
    eval "box#{race.id_lys}"
  end

end
