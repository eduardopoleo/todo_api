require './application'
Dir['./web/**/*.rb'].sort.each { |f| require f }

AppRouter = Web::Router.new

run Web::App.new