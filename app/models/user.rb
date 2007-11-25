require 'digest/sha1'
class User
  # Virtual attribute for the unencrypted password
  attr_accessor :race, :lys_id, :valid

  # authenticates a user by their login name and unencrypted password.
  # raise getcol::badloginpassworderror if bad login
  def self.authenticate(login, password)
    #check_by_lys(login, password)
    u = User.new
    u.check_by_lys(login, password)
    u
  end


  # check the user with his login an password from conquest_lys.
  # raise getcol::badloginpassworderror if bad login
  def check_by_lys(login, password)
    @race, @lys_id = GetCol::check_login(login, password)
  end

  def player
    @player ||= Player.find_by_lys_id @lys_id
  end

end
