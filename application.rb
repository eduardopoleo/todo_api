# load gems
require 'bundler'
Bundler.require

# loads the environment
env = ENV['RUBY_ENV'] || 'development'

Dotenv.load(".env.#{env}")

# set up the DB
Sequel.extension :migration, :core_extensions
Sequel::Model.plugin :timestamps, force: true, update_on_create: true

DB = Sequel.connect(ENV['DATABASE_URL'])

# setup logger
require 'logger'
DB.logger = Logger.new($stdout)
DB.sql_log_level = :debug

# loads app
files = Dir['./app/**/*.rb'].sort
files.each { |f| require f }