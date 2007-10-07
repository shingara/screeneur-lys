
class Map < ActiveRecord::Base
  has_many :boxes

  include InsertMap

  def after_create
    logger.debug 'after_create map'
    show_maintenance
    get_map 
    hide_maintenance
  end

end
