class MapsController < ApplicationController

  include AuthenticatedSystem

  before_filter :login_from_cookie
  before_filter :login_required
  
  def index
    @map = Map.find params[:map_id]
    @page_title = "Carte #{@map.name}"
    @javascripts = ['maps/infojoueur']
    @box_y, @all_x, @all_y  = Box.big_box params[:x].to_i, 
                                          params[:y].to_i, 
                                          params[:step].to_i, 
                                          params[:map_id].to_i
  rescue ActiveRecord::RecordNotFound
    render :status => 404, :file => "#{RAILS_ROOT}/public/404.html"
  end

  def player
    @player = Player.find params[:id]
    render :layout => false
  rescue ActiveRecord::RecordNotFound
    render :status => 500
  end

  def objet
    @objet = Objet.find params[:id]
    render :layout => false
  rescue ActiveRecord::RecordNotFound
    render :status => 500
  end

  # Search By Id Perso
  def search
    unless params[:perso].blank?
      player = Player.find_by_lys_id params[:perso]
      flash[:notice] = "Perso trouvé"
      redirect_to :action => :index,
        :x => player.box.x,
        :y => player.box.y,
        :step => params[:step],
        :map_id => player.box.map.id,
        :perso => params[:perso]
    end
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "La recherche n'a rien donnée. Faite une nouvelle recherche"
    redirect_to :action => :index, 
      :x => params[:x], 
      :y => params[:y],
      :step => params[:step],
      :map_id => params[:map_id],
      :perso => params[:perso]
  end
end
