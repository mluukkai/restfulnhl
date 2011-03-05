require 'rubygems'
require 'sinatra'
require 'statistics'

require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'
require 'erb'

class Numero
  include DataMapper::Resource
  property :id, 			Serial, :key => true
  property :amount, 		Integer, :default => 0
end


class SWSApp < Sinatra::Base

	configure do
	  db_file = File.dirname(File.expand_path(__FILE__)) + "/db.sqlite"

	  DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite://' + db_file)
	  DataMapper.auto_upgrade!
	end

	get '/drop' do
	  DataMapper.auto_migrate!
	  "all dropped <a href=\"/\">back</a>"
	end

	get '/' do
	  @nro = Numero.first(:id => 1)

	  @nro = Numero.new unless @nro  # jos ei löytynyt id:llä "1", niin luo uusi

	  @nro.amount = @nro.amount + 1   # kasvata normaalisti kenttää
	  @nro.save                       # persistoi

    stats = Statistics.new( NHLParser.new )
    @point_order = stats.point_order
    #"#{stats.print_in_goals_order}"
    erb :index
	end

	get '/add' do
		"add"
	end

	post '/add' do

	  "tilaisuus lisatty"

	end

	get '/list' do

		"prkl"
	end

	get '/env' do
	  ENV.inspect
	end
end
