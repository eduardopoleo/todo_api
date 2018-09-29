require 'bundler'
Bundler.require

Dotenv.load

Sequel.extension :migration, :core_extensions
DB = Sequel.connect(ENV['DATABASE_URL'])


