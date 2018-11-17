require 'spec_helper'

# load the app
require_relative '../web/app'

WebApp = App.new 

# main rack entry point
require_relative '../web/entry_point'

# Log web app configs
Dir['./web/config/*.rb'].sort.each { |f| require f }