class ScreensController < ApplicationController

  include ParseMap
  layout 'application'

  filter_parameter_logging (:paste) { |k,v| v[0..10] + v[0..-10] if k =~ /paste/i }

  def new
    @page_title = "Creation d'un screen"
  end

  def create
    raise ParseMapError.new unless params.has_key? :map
    @map = Map.find params[:map]['map_id']
    @plateau = parse_html params[:paste], @map
    
    @screen = Screen.create
    @screen.generate_id
    
    a = render_to_string :file => "#{RAILS_ROOT}/app/views/screens/screen.haml"
    a.gsub! /src="image/, 'src="/image'
    a.gsub! /<a href[^>]+>/, ''
    a.gsub! /<\/a>/, ''
    a.gsub! /background="image/, 'background="/image'
    a.gsub! /src="template/, 'src="/template'

    @screen.save!
    @screen.create_file a
    @screen.save!
    
    redirect_to :action => :show, :id => @screen.view_id

  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Il n\'y a pas de map avec cet identifiant'
    render :action => :new

  rescue ParseMapError
    flash[:notice] = 'Le source que vous avez donnée n\'est pas un screen de Lys, ou vous n\'avez pas donné défini de map'
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
end
