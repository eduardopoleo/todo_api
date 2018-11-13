# All the models and application logid
require_relative '../application'

# The web app config
require_relative './app'

# main rack entry point
require_relative './entry_point'

WebApp = Web::App.new

# Log web app configs
Dir['./web/config/*.rb'].sort.each { |f| require f }

run Web::EntryPoint.new