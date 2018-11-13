require './application'
Dir['./web/**/*.rb'].sort.each { |f| require f }

run Web::App.new