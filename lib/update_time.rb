require "rubygems"
require "bundler/setup"

require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'

require "lib/db_lib"

class UpdateTime
  include DataMapper::Resource
  property :id, 			Serial, :key => true
  property :time,     String, :default => ""

  def self.get_update_time
    DbLib.init
    #UpdateTime.first(:id => 1)
    UpdateTime.first.time
  end

  def self.refresh_update_time
    DbLib.init
    UpdateTime.destroy
	  ut = UpdateTime.new
    ut.time = Time.new.to_s
    ut.save
  end
end

