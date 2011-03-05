require "player"
require 'open-uri'

class NHLParser
  def initialize file = nil
    @contents = []

    if file!= nil
      @contents << open(file)
      return
    end

    base_url = "http://www.nhl.com/ice/app?service=page&page=playerstats&fetchKey=20112ALLAASAll&viewName=summary&sort=points&pg="

    @contents = []

    (1..28).each do |number|
      page = base_url+number.to_s
      @contents << open(page)
    end
  end

  def scan_until_start
    start_of_stat_rows = Regexp.new("<!-- stats rows -->")

    while true do
      line = @content.gets
      break if (line =~ start_of_stat_rows) != nil
    end
  end

  def extract_lines_with_stats
    end_of_stat_rows = Regexp.new("<!-- end 	statsTableGoop -->")

    stats = ""
    while true do
      line = @content.gets.chop
      break if (line =~ end_of_stat_rows) != nil
      stats += line
    end
    stats
  end

  def parse
    players = []

    @contents.each do |content|
      @content = content
      parse_page.each { |player| players << player }
    end
    players
  end

  def parse_page
    scan_until_start
    stats = extract_lines_with_stats()

    players = []

    stats.split( "\<tr" ).each do |player_stat|
      player = extract_player player_stat
      players << player if player != nil
    end
    players
  end

  def extract_player(player_stat)
    fields = player_stat.split("\<td")
    return if fields[2] == nil

    name = extract_name_field fields[2]
    team = extract_normal_field fields[3]
    games = ( extract_normal_field fields[5] ).to_i
    goals = ( extract_normal_field fields[6] ).to_i
    assists = ( extract_normal_field fields[7] ).to_i

    { :name => name, :team => team, :games => games, :goals => goals, :assists => assists}
  end

  def extract_name_field field
    re = Regexp.new( "\<a(.*)\<\/a\>" )
    remains = field.match( re )[1]
    re = Regexp.new( "\>(.*)$" )
    remains.match( re )[1]
  end

  def extract_normal_field field
    re = Regexp.new( "\>(.*)\<\/td\>" )
    field.match( re )[1].rstrip.lstrip
  end
end

