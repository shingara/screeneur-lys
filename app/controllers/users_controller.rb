class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # render new.rhtml
  def new
  end

  def create
    @user = User.new(params[:user])
    player_user = Player.find_by_lys_id params[:user][:player_id]
    unless player_user.nil?
      @user.player = player_user     
      @user.save!
      self.current_user = @user
      redirect_to :controller => :maps, 
        :action => :index, 
        :x => @user.player.box.x, 
        :y => @user.player.box.y,
          :step => 10,
        :map_id => @user.player.box.map.id
      flash[:notice] = "Merci pour votre enregistrement"
    else
      flash[:notice] = 'Votre matricule n\'existe pas dans la Base de donnée. Soit elle est éronné, soit vous n\'avez jamais fait de screen.'
      redirect_to '/'
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def activate
    self.current_user = User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.activated?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end

end
