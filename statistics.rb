require "lib/player"
require "lib/nhl_parser"

require "rubygems"
require "bundler/setup"

require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'

class Statistics
  def initialize
    db_file = File.dirname(File.expand_path(__FILE__)) + "/db.sqlite"
	  DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite://' + db_file)
  end

  def fetch parser
    DataMapper.auto_migrate!
    parser.parse.each do |player|
      p = Player.add( player[:name], player[:team], player[:games], player[:goals], player[:assists] )
    end
  end

  def get_players
    player_list = []
    Player.all().each do |player|
      player_list << player
    end
    player_list
  end

  def point_order
    get_players().sort_by { |p| p.points }.reverse
  end

  def goal_order
    get_players().sort_by { |p| p.goals }.reverse
  end

  def assist_order
    get_players().sort_by { |p| p.assists }.reverse
  end

  def print_in_point_order
    puts "pisteporssi:"
    puts "============"
    point_order.each do |player|
      puts player
    end
  end

  def print_in_goals_order
    puts "maaliporssi:"
    puts "============"
    goal_order.each do |player|
      puts player
    end
  end

  def print_in_assists_order
    puts "syottoporssi:"
    puts "============"
    assist_order.each do |player|
      puts player
    end
  end
end

s = Statistics.new
s.fetch  NHLParser.new "stats.html"
s.print_in_goals_order
puts
s.print_in_assists_order
puts
s.print_in_point_order

