class ArchiveController < ApplicationController

  include AuthenticatedSystem

  before_filter :login_required

  def index
    @screen = Screen.paginate_by_race_id self.current_user.race, :page => params[:page], :order => "id DESC"
  end
end
