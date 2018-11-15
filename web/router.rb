module Web
  class Router
    attr_reader :routes

    HTTP_VERBS = [:get, :patch, :post, :put, :delete].freeze

    def initialize
      @routes = []
    end

    def config(&block)
      # Here I need to use instance_eval otherwise the block gets executed on the
      # context of the routes file. But I want the contex of the router instance
      # because it's in here where I have access to the @routes instance variable
      # and the method definitions get, post put
      instance_eval(&block)
    end

    def match(verb, path)
      routes.find { |r| r[:verb] == verb.downcase && r[:path] == path.downcase }
    end

    HTTP_VERBS.each do |method|
      define_method(method) do |path, options|
        routes << { verb: method.to_s, path: path.downcase, controller: options[:to] }
      end
    end
  end
end