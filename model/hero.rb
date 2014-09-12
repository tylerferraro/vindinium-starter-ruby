class Hero
  def attr_reader :id, :name, :elo, :pos, :life, :gold, :mine_count

  def initialize data
    @id = data['id']
    @name = data['name']
    @user_id = data['userId']
    @elo = data['elo']
    @pos = { 'x' => data['pos']['x'], 'y' => data['pos']['y'] }
    @life = data['life']
    @gold = data['gold']
    @mine_count = data['mineCount']
    @spawn_pos = { 'x' => data['spawnPos']['x'], 'y' => data['spawnPos']['y'] }
    @crashed = data['crashed']
  end

  def has_crashed?
    @crashed
  end
end