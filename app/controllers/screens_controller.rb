class ScreensController < ApplicationController

  include ParseMap
  layout 'application'

  caches_action :new
  caches_action :show

  def new
    @page_title = "Creation d'un screen"
  end

  def create
    raise ParseMapError if params[:paste].empty?
    create_map params[:paste], nil, params[:race]
    redirect_to :action => :show, :id => @screen.view_id

  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Il n\'y a pas de map avec cet identifiant'
    render :action => :new

  rescue ParseMapError
    flash[:notice] = 'Le source que vous avez donnée n\'est pas un screen de Lys ou est vide'
    render :action => :new
  end

  def show
    @page_title = "Screen #{params[:id]}"
    @javascripts = ['screens/infojoueur', 'screens/infoobjet']
    @screen = Screen.find_by_view_id params[:id]
    if @screen
      render :layout => 'screens', :file => @screen.location
    else
      render :status => 404, :file => "#{RAILS_ROOT}/public/404.html"
    end
  end

  def script
    unless params[:screen]
      render :text => 'KO', :status => 400
    else
      parse_html params[:screen], params[:race], params[:map_id]
      render :text => 'OK'
    end
  end
end
