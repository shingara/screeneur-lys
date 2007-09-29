require 'get_source'

class CheckController < ApplicationController

  include ParseMap

  def index
  end

  def create
    plateau_first, plateau_second = GetCol.get_map(params[:login], params[:password])
  
    create_map plateau_first, 1
    @map_first = @screen.view_id 
  
    create_map plateau_second, 2
    @map_second = @screen.view_id
  end
end
