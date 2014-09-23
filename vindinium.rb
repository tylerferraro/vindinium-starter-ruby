#!/usr/bin/ruby

require 'optparse'
require './bots/assassin'
require './client'

# Runs the Vindinium game using the supplied options
class Vindinium
  attr_reader :vindinium_client, :number_of_games

  def initialize opts
    @opts = opts
    url_mapping = Hash.new
    url_mapping['arena'] = 'http://vindinium.org/api/arena'
    url_mapping['training'] = 'http://vindinium.org/api/training'

    raise "Missing secret key" unless opts.include?(:secret_key)

    opts[:mode] ||= 'training'
    opts[:server] ||= url_mapping[opts[:mode]]
    opts[:number_of_games] ||= 1

    @vindinium_client = Client.new opts
    @bot = AssassinBot.new
  end

  def run_games
    #@number_of_games.times do |game_number|
      game_state = @vindinium_client.request_new_game 'training'
      play_url = game_state.play_url
      view_url = game_state.view_url
      puts "Url: #{view_url}"

      until game_state.is_finished?
        dir = @bot.move game_state.board
        puts "Moving: #{dir}"
        game_state = @vindinium_client.send_move play_url, dir
      end
    #end
  end
end

options = { }
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: vindinium.rb -k secret_key [-g arena|training] [-m map] [-t turns] [-s server_url] [-n number_of_games]"

  opts.on('-d', '--debug', 'Run in debug mode') { options[:debug] = true }
  opts.on('-k', '--key KEY', 'Secret key for bot') { |key| options[:secret_key] = key }
  opts.on('-g', '--game-mode MODE', 'Game mode arena|training') { |game_mode| options[:mode] = game_mode }
  opts.on('-m', '--map MAP', 'Map to use') { |map| options[:map] = map }
  opts.on('-t', '--turns TURNS', 'Number of turns') { |turns| options[:turns] = turns }
  opts.on('-s', '--server SERVER_URL', 'Server url for connection') { |server| options[:server] = server }
  opts.on('-n', '--number-of-games NUMBER', 'Number of games to run') { |num| options[:number_of_games] = num }
end

optparse.parse!

vindinium = Vindinium.new options
vindinium.run_games()