# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # If you want "remember me" functionality, add this before_filter to Application Controller

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      flash[:notice] = "Connection réussi"
      if self.current_user.player.nil? || self.current_user.player.box.nil?
        redirect_to_check
      else
        redirect_to map_view_url(self.current_user.player.box.x, self.current_user.player.box.y, 10, self.current_user.player.box.map.id)
      end
    else
      flash[:notice] = "Ce login ou mot de passe est éronnée"
      render :action => 'new'
    end
  rescue GetCol::BadLoginPasswordError
    flash[:notice] = "Ce login ou mot de passe est éronné"
    render :action => 'new'
  end

  def destroy
    self.current_user = nil if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Vous avez été déconnecté."
    redirect_back_or_default('/')
  end
end
