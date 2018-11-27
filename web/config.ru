# All the models and application logid
require_relative '../application'

# The web app config
require_relative './app'

WebApp = App.new

# main rack entry point
require_relative './entry_point'

# Load web app configs
Dir['./web/config/*.rb'].sort.each { |f| require f }

options = {
  :key => 'rack.session',
  :domain => 'localhost',
  :path => '/',
  :expire_after => 2592000,
  :secret => ENV['SESSION_SECRET'],
  :old_secret => ENV['OLD_SESSION_SECRET']
}

use Rack::Session::Cookie, options

run EntryPoint.new