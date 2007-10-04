class Notifier < ActionMailer::Base

  def picture_downloaded (file_download)
      @recipients  = "cyril.mougel@gmail.com"
      @from        = "cyril.mougel@gmail.com"
      @subject     = "[SCREENEUR] Picture download"
      @sent_on     = Time.now
      @body[:file_download] = file_download
  end
end
