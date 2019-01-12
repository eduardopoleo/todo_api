# load gems
require 'bundler'
Bundler.require

# loads the environment
env = ENV['RUBY_ENV'] || 'development'

Dotenv.load(".env.#{env}")

# set up the DB
Sequel.extension :migration, :core_extensions
Sequel::Model.plugin :timestamps, force: true, update_on_create: true

# the string 'db' will translate to the host where the db is on docker
DB = Sequel.connect(ENV['DATABASE_URL'])

# setup logger
require 'logger'
DB.logger = Logger.new($stdout)
DB.sql_log_level = :debug

# loads app
files = Dir['./app/**/*.rb'].sort
files.each { |f| require f }