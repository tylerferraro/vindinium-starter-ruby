require "#{File.dirname(__FILE__)}/state"

class Game
  attr_reader :play_url, :view_url, :state

  def initialize data
    @play_url = data['playUrl']
    @view_url = data['viewUrl']
    @state = State.new data['game']
  end

  def is_finished?
    @state.is_finished?
  end
end