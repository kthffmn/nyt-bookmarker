require_relative 'config/environment.rb'

ENV["SINATRA_ENV"] ||= "development"

require 'sinatra/activerecord/rake'

require "sinatra/activerecord/rake"
Dir.glob('lib/tasks/*.rake').each { |r| load r}
