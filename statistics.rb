require "player"
require "nhl_parser"
require "lib/db_lib"
require "lib/update_time"

require "rubygems"
require "bundler/setup"

class Statistics
  def initialize
    DbLib.init
  end

  def fetch parser
    DbLib.drop_tables
    parser.parse.each do |player|
      Player.add( player )
    end
    UpdateTime.refresh_update_time
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

  def pim_order
    get_players().sort_by { |p| p.pim }.reverse
  end

  def plusminus_order
    get_players().sort_by { |p| p.plusminus }.reverse
  end

  def shots_order
    get_players().sort_by { |p| p.shots }.reverse
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

#s = Statistics.new
#s.fetch  NHLParser.new "stats.html"
#s.print_in_goals_order
#puts
#s.print_in_assists_order
#puts
#s.print_in_point_order

