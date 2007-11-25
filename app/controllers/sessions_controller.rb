# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      flash[:notice] = "Connection réussi"
      if self.current_user.player.nil?
        flash[:notice] += " Vous n'avez pas informer de votre position. Sans cette formalité, vous ne pourrez pas vous connecter"
        redirect_to :controller => 'check', :action => 'index'
      else
        redirect_to map_view_url(self.current_user.player.box.x, self.current_user.player.box.y, 10, self.current_user.player.box.map.id)
      end
    else
      flash[:notice] = "Ce login ou mot de passe est éronnée"
      render :action => 'new'
    end
  rescue GetCol::BadLoginPasswordError
    flash[:notice] = "Ce login ou mot de passe est éronné rescue"
    render :action => 'new'
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
