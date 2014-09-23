class AssassinBot
  def initialize
    @direction = ["Stay", "North", "South", "East", "West"]
  end

  #model/gameboard.rb
  def move game_board
    @direction.sample
  end
end