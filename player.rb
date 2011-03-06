require "rubygems"
require "bundler/setup"

require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'

class Player
  include DataMapper::Resource
  property :id, 			Serial, :key => true
  property :name,     String, :default => ""
  property :url,     String, :default => ""
  property :team,     String, :default => ""
  property :games, 		Integer, :default => 0
  property :goals, 		Integer, :default => 0
  property :assists,  Integer, :default => 0
  property :points,   Integer, :default => 0
  property :pim,      Integer, :default => 0
  property :plusminus,Integer, :default => 0
  property :shots,    Integer, :default => 0

  def self.add player_string 
    p = Player.new
    p.name = player_string[:name]
    p.url = player_string[:url]
    p.team = player_string[:team]
    p.games = player_string[:games]
    p.goals = player_string[:goals]
    p.assists = player_string[:assists]
    p.points = p.goals + p.assists
    p.pim = player_string[:pim]
    p.plusminus = player_string[:plusminus]
    p.shots = player_string[:shots]
    p.save
    p
  end

  def assists
    @assists
  end

  def to_s
    "#{@name.ljust(20)} #{@team}   #{@games}  #{@goals} + #{@assists} = #{@points}"
  end
end





