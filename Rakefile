require_relative 'config/environment.rb'

namespace :db do

  desc "Migrate the db"
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  task :seed do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    require_relative "db/seeds.rb"
    class Seed
      def get_data
        JSON.parse(File.read("db/articles.json"))
      end
    end
    Seed.new(ENV['NEW_YORK_TIMES_KEY']).run
  end

  desc "drop and recreate the db"
  task :reset => [:drop, :migrate]

  desc "drop the db"
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Migrator.down("db/migrate/", 0)
  end
end

task :console do 
  Pry.start
end
