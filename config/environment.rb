ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require 'json'
require 'yaml'
require 'open-uri'
require 'active_record'
Dotenv.load

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

require_all 'app'

RAKE_APP ||= Rake.application
