class AssassinBot
  def initialize
    @direction = ["Stay", "North", "South", "East", "West"]
  end

  #lib/board.rb
  def move game_state
    @direction.sample
  end
end