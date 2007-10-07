class Player < ActiveRecord::Base
  include DownloadPicture

  has_one :box
  belongs_to :compagny
  belongs_to :grade
  belongs_to :weapon
  belongs_to :race
  validates_uniqueness_of :identification
  
  def after_save
    check_picture_exist picture
  end

end
