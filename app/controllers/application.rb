# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_screeneur_session_id'

  include ExceptionNotifiable
  include AuthenticatedSystem

private

  # Redirect to check page with a notice
  def redirect_to_check
    flash[:notice] = '' if flash[:notice].nil?
    flash[:notice] += " Vous n'avez pas informer de votre position. Sans cette formalité, vous ne pourrez pas vous connecter"
    redirect_to :controller => 'check', :action => 'index'
  end
end
