class GameBoard
  def attr_reader :size

  def initialize data
    @size = data["size"]
    @board = data["tiles"].scan(/../).map{ |str| Tile.new }
  end

  class Tile
    def initialize str

    end
  end
end