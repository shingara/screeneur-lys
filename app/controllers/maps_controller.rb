class MapsController < ApplicationController

  include AuthenticatedSystem

  #before_filter :login_from_cookie
  #before_filter :login_required
  
  def index
    #center_box = current_user.player.box
    @box_y, @all_x, @all_y  = Box.big_box params[:x].to_i, 
      params[:y].to_i, params[:step].to_i
  end
end
