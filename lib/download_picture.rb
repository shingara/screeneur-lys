module DownloadPicture
  
  def check_picture_exist(file_to_download)
    return if File.exist? "#{RAILS_ROOT}/public/#{file_to_download}"
    
    puts "download file #{file_to_download}"
    
    dir = File.dirname file_to_download
    File.makedirs "#{RAILS_ROOT}/public/#{dir}" unless File.exist? "#{RAILS_ROOT}/public/#{dir}"
    img = Net::HTTP.get 'conquest-lys.net', "/#{file_to_download}"
    f = File.open "#{RAILS_ROOT}/public/#{file_to_download}", 'wb'
    f.write img
    f.close
  rescue SocketError
    puts "No network for download #{file_to_download}"
  end

end
