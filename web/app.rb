require_relative './router'

class App
  attr_reader :router

  def initialize
    @router = Router.new
  end
end
