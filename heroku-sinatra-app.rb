require "rubygems"
require "bundler/setup"
require 'sinatra'

require 'erb'

require 'statistics'
require 'formatter'
require "lib/update_time"

class SWSApp < Sinatra::Base

	configure do
    Statistics.new.fetch(NHLParser.new "stats.html")
	end

  get '/reload_statistics' do
    Statistics.new.fetch(NHLParser.new "stats.html")
    "statistics reloaded"
  end

  def get_points_order
    Statistics.new.point_order
  end

  def get_goals_order
    Statistics.new.goal_order
  end

  def get_assists_order
    Statistics.new.assist_order
  end

  get '/' do
    redirect '/points'
  end

  get '/points' do
    @list = get_points_order
    @msg = "NHL statistics - ordered by total points"
    @formatter = Formatter.point
    @updated = UpdateTime.get_update_time
    erb :tableform
  end

  get '/goals' do
    @list = get_goals_order
    @msg = "NHL statistics - ordered by total goals"
    @formatter = Formatter.goal
    @updated = UpdateTime.get_update_time
    erb :tableform
    end

  get '/assists' do
    @list = get_assists_order
    @msg = "NHL statistics - ordered by total assists"
    @formatter = Formatter.assist
    @updated = UpdateTime.get_update_time
    erb :tableform
	end

end

