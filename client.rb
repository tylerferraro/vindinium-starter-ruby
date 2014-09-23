class Client
  require 'httpclient'
  require 'json'
  require './model/gamestate'

  attr_reader :mode, :server, :debug

  def initialize opts
    required_opts = [:secret_key, :mode, :server]
    unless (required_opts - opts.keys).empty?
      raise "Missing required parameters: #{required_opts - opts.keys}"
    end

    @secret_key = opts[:secret_key]
    @mode = opts[:mode].to_sym
    @server = opts[:server]

    #opts.each_pair { |k, v| self.send("#{k}=", v) }

    @debug ||= false

    @http_client = HTTPClient.new
    @http_client.debug_dev = $stdout if @debug
  end

  def request_new_game mode
    params = { 'key' => @secret_key } if mode == 'training'
    params = { 'key' => @secret_key } if mode == 'arena'

    response = @http_client.post(@server, params)

    unless response.status == 200
      #TODO: log response.body
      raise "Error requesting new game. Received response code: #{response.status}"
    end

    GameState.new JSON.parse(response.body)
  end

  def send_move url, dir
    params = { :key => @secret_key, :dir => dir }
    response = @http_client.post(url, params)

    unless response.status == 200
      #TODO: log response.body
      raise "Error sending move. Received response code: #{response.status}"
    end

    GameState.new JSON.parse(response.body)
  end
end