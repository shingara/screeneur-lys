class Box3 < Box

  before_update :update_date_box

  def player=(player)
    raise ArgumentError.new('This argument must be a Player object') unless player.kind_of? Player

    self.player_3_id = player.id
  end

  private

  def update_date_box
    self.update_3 = DateTime.now
  end
end
