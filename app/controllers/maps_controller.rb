class MapsController < ApplicationController

  include AuthenticatedSystem

  before_filter :login_from_cookie
  before_filter :login_required
  
  def index
    @map = Map.find params[:map_id]
    @page_title = "Carte #{@map.name}"
    @javascripts = ['maps/infojoueur']
    @box_y, @all_x, @all_y  = Box.big_box params[:x].to_i, 
      params[:y].to_i, params[:step].to_i, params[:map_id].to_i
  rescue ActiveRecord::RecordNotFound
    render :status => 404, :file => "#{RAILS_ROOT}/public/404.html"
  end
end
