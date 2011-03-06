require "rubygems"
require "bundler/setup"

require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'

DataMapper.setup(:default, 'sqlite::memory:')

class Player
  include DataMapper::Resource
  property :id,       Serial, :key => true
  property :name,     String, :default => ""
  property :team,     String, :default => ""
  property :games,    Integer, :default => 0
  property :goals,    Integer, :default => 0
  property :assists,  Integer, :default => 0
  property :points,   Integer, :default => 0

  # seuraava pois kommentista niin ei toimi:
  #
  attr_accessor :goals, :assists, :points

  def initialize 
  end

  def self.add name, team, games, goals, assists
    p = Player.new 
    p.name = name
    p.team = team
    p.games = games
    p.goals = goals
    p.assists = assists
    p.points = goals + assists
    p.save
    p
  end

  def to_s
    "#{@name.ljust(20)} #{@team}   #{@games}  #{@goals} + #{@assists} = #{@points}"
  end
end

DataMapper.auto_migrate!

Player.add "Jokinen", "Kalpa", 1, 2, 3

puts Player.get(1)
