# All the models and application logid
require_relative '../application'

# The web app config
require_relative './app'

WebApp = App.new

# main rack entry point
require_relative './entry_point'


# Log web app configs
Dir['./web/config/*.rb'].sort.each { |f| require f }

run EntryPoint.new