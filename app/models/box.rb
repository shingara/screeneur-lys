class Box < ActiveRecord::Base
  belongs_to :player
  belongs_to :type
end
