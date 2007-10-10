module DownloadPicture
  
  # See if the file is to download and if it's not exist
  # it's donwload it by lys conquest 
  def check_picture_exist(file_to_download)
    return if File.exist? "#{RAILS_ROOT}/public/#{file_to_download}"
    
    logger.info "download file #{file_to_download}"
    
    dir = File.dirname file_to_download
    File.makedirs "#{RAILS_ROOT}/public/#{dir}" unless File.exist? "#{RAILS_ROOT}/public/#{dir}"
    img = Net::HTTP.get 'conquest-lys.net', "/#{file_to_download}"
    f = File.open "#{RAILS_ROOT}/public/#{file_to_download}", 'wb'
    f.write img
    f.close

    Notifier.deliver_picture_downloaded(file_to_download)

  rescue SocketError
    logger.warn "No network for download #{file_to_download}"
  end

end
