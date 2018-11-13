module Web
  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    def config(&block)
      # Here I need to use instance_eval otherwise the block gets executed on the
      # context of the routes file but I want it here 
      instance_eval(&block)
    end

    def get(path, options)
      routes << { verb: 'get', path: path, controller: options[:to] }
    end
  end
end
__END__

AppRouter.config do
  get '/users', to: 'users#index'
  post '/invitations', to: ''
end

=> routes = [
  { verb: 'get', path: '/users', class: Web::Handlers::Invitations::Index },
  { verb: 'post', path: '/invitations', class: Web::Handlers::Invitations::Create }
]

AppRouter.match(path)

def find_handler(path)
  routes.select { |r| r[:path] == '/users' }.first
end


