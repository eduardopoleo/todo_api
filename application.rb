# load gems
require 'bundler'
Bundler.require

# loads the environment
Dotenv.load

# set up the DB
Sequel.extension :migration, :core_extensions
Sequel::Model.plugin :timestamps, force: true, update_on_create: true

DB = Sequel.connect(ENV['DATABASE_URL'])

# loads app
files = Dir['./app/**/*.rb'].sort
files.each { |f| require f }