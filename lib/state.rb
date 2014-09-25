class State
  require "#{File.dirname(__FILE__)}/hero"
  require "#{File.dirname(__FILE__)}/board"

  attr_reader :id, :turn, :max_turns, :heroes, :board

  def initialize data
    @id = data['id']
    @turn = data['turn']
    @max_turns = data['maxTurns']
    @heroes = data['heroes'].each { |hero| Hero.new hero }
    @board = Board.new data['board']
    @finished = data['finished']
  end

  def is_finished?
    @finished
  end
end