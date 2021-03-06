class MapsController < ApplicationController

  include AuthenticatedSystem

  before_filter :login_required
  
  def index
    @map = Map.find params[:map_id]
    @page_title = "Carte #{@map.name}"
    @javascripts = ['maps/infojoueur']

    @top = params[:y].to_i - (params[:step].to_i / 2)
    @bottom = params[:y].to_i + (params[:step].to_i / 2)
    @right = params[:x].to_i + (params[:step].to_i / 2)
    @left = params[:x].to_i - (params[:step].to_i / 2)

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
  def search_perso
    unless params[:perso].blank?
      player = Player.find_by_lys_id params[:perso]
      raise ActiveRecord::RecordNotFound if player.nil?
      if player.box(self.current_user).nil?
        redirect_to_check
      else
        flash[:notice] = "Perso trouvé"
        redirect_to map_view_url(player.box(self.current_user).x, 
                               player.box(self.current_user).y,
                               10,
                               player.box(self.current_user).map.id)
      end
    end
  rescue ActiveRecord::RecordNotFound,  ActiveRecord::StatementInvalid
    flash[:notice] = "La recherche n'a rien donnée. Faite une nouvelle recherche"
    index
    render :action => "index"
  end

end
