class Board
  def initialize data
    @size = data['size']
    @board = data['tiles'].scan(/../).map{ |str| Tile.new str }
  end

  def to_s
    @board.each_index do |i|
      print @board[i]
      print "\n" if (i + 1) % @size == 0
    end
  end

  class Tile
    attr_reader :str, :type, :owned, :owner

    def initialize str
      @str = str

      if @str.start_with? '$'
        @type = :gold_mine
        @owned = !(@str.end_with? '-')
        @owner = @owned ? @str[-1] : nil
      elsif @str.start_with? '@'
        @type, @owned, @owner = :player, true, @str[-1]
      else
        @type = :empty   if @str == '  '
        @type = :blocked if @str == '##'
        @type = :tavern  if @str == '[]'
      end

      @type  ||= :unknown
      @owned ||= false
      @owner ||= nil
    end

    def to_s
      @type.to_s[0]
    end
  end
end