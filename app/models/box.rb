class Box < ActiveRecord::Base
  belongs_to :player
  belongs_to :type
  belongs_to :map
end
