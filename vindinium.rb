#!/usr/bin/ruby

require 'optparse'

# Runs the Vindinium game using the supplied options
class Vindinium
  attr_reader :vindinium_client, :number_of_games

  def initialize opts
    url_mapping = Hash.new
    url_mapping['arena'] = 'https://vindinium.org/api/arena'
    url_mapping['training'] = 'https://vindinium.org/api/training'

    unless opts.include?(:secret_key)
      puts "Missing secret key parameter"
      exit 1
    end

    opts[:mode] ||= 'training'
    opts[:server] ||= url_mapping[opts[:mode]]
    opts[:number_of_games] ||= 1

    @vindinium_client = Client.new opts
  end

  def run_games
    @number_of_games.times do |game_number|
      @vindinium_client.start_new_game
      @vindinium_client.print_game_results
    end
  end
end

options = { }
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: vindinium.rb -k secret_key [-g arena|training] [-m map] [-t turns] [-s server_url] [-n number_of_games]"

  opts.on('-d', '--debug', 'Run in debug mode') { options[:debug] = true }
  opts.on('-k', '--key', 'Secret key for bot') { |key| options[:secret_key] = key }
  opts.on('-g', '--game-mode', 'Game mode arena|training') { |game_mode| options[:mode] = game_mode }
  opts.on('-m', '--map', 'Map to use') { |map| options[:map] = map }
  opts.on('-t', '--turns', 'Number of turns') { |turns| options[:turns] = turns }
  opts.on('-s', '--server', 'Server url for connection') { |server| options[:server] = server }
  opts.on('-n', '--number-of-games', 'Number of games to run') { |num| options[:number_of_games] = num }
end

vindinium = Vindinium.new options
vindinium.run_games()