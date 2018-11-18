Dir['./web/controllers/**/**.rb'].sort.each { |f| require f }

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

  def execute(controller, params)
    resource, action = controller.split('#')
    controller(classify(resource), classify(action)).new(params).send(:execute)
  end

  HTTP_VERBS.each do |method|
    define_method(method) do |path, options|
      routes << { verb: method.to_s, path: path.downcase, controller: options[:to] }
    end
  end

  private

  def classify(class_name)
    class_name.split('_').collect!{ |w| w.capitalize }.join
  end

  def controller(resource, action)
    class_name = [resource + 'Controllers', action].join('::')

    Module.const_get(class_name)
  end
end
