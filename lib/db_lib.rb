require "rubygems"
require "bundler/setup"

require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'

class DbLib
  def self.init
    db_file = File.dirname(File.expand_path(__FILE__)) + "/db.sqlite"
	  DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite://' + db_file)
  end

  def self.drop_tables
    DataMapper.auto_migrate!
  end
end
