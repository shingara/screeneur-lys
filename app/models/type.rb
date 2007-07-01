class Type < ActiveRecord::Base
  include DownloadPicture
  
  def after_save
    check_picture_exist(name)
  end

end
