class Objet < ActiveRecord::Base
  include DownloadPicture

  belongs_to :box

  def after_save
    check_picture_exist(picture)
  end
end
