class Client
  require 'httpclient'
  require 'json'

  attr_reader :secret_key, :mode, :server, :map, :turns, :http_client, :debug

  def initialize opts
    required_opts = [:secret_key, :mode, :server]
    unless (required_opts - opts).empty?
      puts "Missing required parameters"
      exit 1
    end

    opts.each_pair { |k, v| self.send("#{k}=", v) }

    @debug ||= false

    @http_client = HTTPClient.new
    @http_client.debug_dev = $stdout if @debug
  end

  def start_new_game
    @game_state = self.request_new_game


  end

  def request_new_game
    params = { :key => @secret_key, :number_of_turns => @turns, :map => @map }
    response = @http_client.post(@server, params)
    if response.status == 200
      game_data = JSON.parse response.body
    else
      puts "Error requesting new game"
      puts response.body
    end

    return game_data
  end
end