require "rubygems"
require "bundler/setup"

require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'

class Player
  include DataMapper::Resource
  property :id, 			Serial, :key => true
  property :name,     String, :default => ""
  property :team,     String, :default => ""
  property :games, 		Integer, :default => 0
  property :goals, 		Integer, :default => 0
  property :assists,  Integer, :default => 0
  property :points,   Integer, :default => 0

  def initialize name, team, games, goals, assists
    @name = name
    @team = team
    @games = games
    @goals = goals
    @assists = assists
    @points = @goals + @assists
  end

  def self.add name, team, games, goals, assists
    p = Player.new name, team, games, goals, assists
    p.name = name
    p.team = team
    p.games = games
    p.goals = goals
    p.assists = assists
    p.points = goals + assists
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





