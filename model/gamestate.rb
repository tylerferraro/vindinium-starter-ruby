class GameState
  require './model/hero'
  require './model/gameboard'

  attr_reader :id, :turn, :max_turns, :heroes, :board, :play_url, :view_url

  def initialize data
    game_data = data['game']

    @id = game_data['id']
    @turn = game_data['turn']
    @max_turns = game_data['maxTurns']
    @heroes = game_data['heroes'].each { |hero| Hero.new hero }
    @board = GameBoard.new game_data['board']
    @finished = game_data['finished']
    @play_url = data['playUrl']
    @view_url = data['viewUrl']
  end

  def is_finished?
    @finished
  end
end