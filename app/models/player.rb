class Player < ActiveRecord::Base
  include DownloadPicture

  has_one :box1, :foreign_key => "player_1_id"
  has_one :box2, :foreign_key => "player_2_id"
  has_one :box3, :foreign_key => "player_3_id"
  has_one :box4, :foreign_key => "player_4_id"

  belongs_to :compagny
  belongs_to :grade
  belongs_to :weapon
  belongs_to :race
  
  validates_uniqueness_of :identification
  
  def after_save
    check_picture_exist picture
  end

end
