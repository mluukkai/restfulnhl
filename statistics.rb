require "player"
require "nhl_parser"
require "nhl_parser2"

class Statistics
  def initialize parser
    @players = []

    parser.parse.each do |player|
      p = Player.new( player[:name], player[:team], player[:games], player[:goals], player[:assists] )
      @players << p
    end
  end

  def point_order
    @players.dup
  end

  def goal_order
    @players.dup.sort_by { |p| p.goals }.reverse
  end

  def assist_order
    @players.dup.sort_by { |p| p.assists }.reverse
  end

  def print_in_point_order
    puts "pistepörssi:"
    puts "============"
    point_order.each do |player|
      puts player
    end
  end

  def print_in_goals_order
    puts "maalipörssi:"
    puts "============"
    goal_order.each do |player|
      puts player
    end
  end

  def print_in_assists_order
    puts "syöttöpörssi:"
    puts "============"
    assist_order.each do |player|
      puts player
    end
  end
end

s = Statistics.new( NHLParser2.new )
s.print_in_goals_order
puts
s.print_in_assists_order
puts
s.print_in_point_order
