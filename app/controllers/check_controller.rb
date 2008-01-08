
class CheckController < ApplicationController

  include ParseMap

  def index
  end

  def create
    plateau_first, map_name_first, plateau_second, map_name_second, race_id = GetCol.get_map(params[:login], params[:password])
  
    create_map plateau_first, map_name_first, race_id
    @map_first = @screen.view_id 
  
    create_map plateau_second, map_name_second, race_id
    @map_second = @screen.view_id
  rescue GetCol::BadLoginPasswordError
    flash[:notice] = "Votre login/pass n'est pas valide sur ConquestOfLys"
    render :action => "index"

  end
end
