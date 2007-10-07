require 'get_source'

class CheckController < ApplicationController

  include ParseMap

  def index
  end

  def create
    plateau_first, map_name_first, plateau_second, map_name_second = GetCol.get_map(params[:login], params[:password])
  
    create_map plateau_first, map_name_first
    @map_first = @screen.view_id 
  
    create_map plateau_second, map_name_second
    @map_second = @screen.view_id
  end
end
