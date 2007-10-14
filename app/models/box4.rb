class Box4 < Box

  before_update :update_date_box

  def player=(player)
    raise ArgumentError.new('This argument must be a Player object') unless player.kind_of? Player

    self.player_4_id = player.id
  end

  private

  def update_date_box
    self.update_4 = DateTime.now
  end
end
