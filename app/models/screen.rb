class Screen < ActiveRecord::Base

  validates_uniqueness_of :view_id

  cattr_reader :per_page
  @@per_page = 20

  BASE_PATH = "#{RAILS_ROOT}/app/views/screens/all"

  def create_file content
    f = File.open(location, 'w')
    f.write content
    f.close
  end

  def location
    "#{BASE_PATH}/#{id}.html"
  end

  def generate_id
    id_tmp = Digest::SHA1.hexdigest(rand(rand).to_s)
    id_tmp = generate_id unless Screen.count(:conditions => ['view_id = ?', id_tmp]) 
    self.view_id = id_tmp
  end
end
