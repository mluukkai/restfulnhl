require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'erb'

require 'content'


class RESTfulNHL < Sinatra::Base
 
	configure do
    Content.fetch_contents "stats.html"
  end

  get '/reload_statistics' do
    Content.fetch_contents 
    "statistics reloaded"
  end

  get '/' do
    redirect '/points'
  end

  get '/:page' do
    content = Content.get_page params[:page]
    @list = content.list
    @msg  = content.msg
    @formatter = content.formatter
    @updated = Content.update_time
    erb :tableform
  end

end

