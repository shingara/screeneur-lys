class Objet < ActiveRecord::Base
  include DownloadPicture

  has_many :box

  def after_save
    check_picture_exist(picture)
  end
end
