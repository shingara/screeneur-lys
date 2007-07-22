class MapsController < ApplicationController

  include AuthenticatedSystem

  #before_filter :login_from_cookie
  #before_filter :login_required

  def index
    #center_box = current_user.player.box
    center_box = Player.find(5).box
    @box_y, @all_x, @all_y  = center_box.big_box 5
  end
end
