require_relative './router'

module Web
  class App
    attr_reader :router

    def initialize
      @router = Router.new
    end
  end
end