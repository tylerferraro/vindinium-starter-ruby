class GameState
  def attr_reader :id, :turn, :max_turns, :heroes, :board

  def initialize data
    @id = data["id"]
    @turn = data["turn"]
    @max_turns = data["maxTurns"]
    @heroes = data["heroes"]
    @board = GameBoard.new data["board"]
    @finished = data["finished"]
  end

  def is_finished?
    @finished
  end
end