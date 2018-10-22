# loads application logic
require_relative '../application'

# loads all the web handlers
files = Dir['./web/handlers/**/*.rb'].sort
files.each { |f| require f }

module Web
  class App
    def call(env)
      req = Rack::Request.new(env)
      params = JSON.parse(req.body.read)
      token = env['HTTP_AUTHORIZATION']

      if req.post?
        case req.path
        when '/users'
          status, headers, body = Web::Handlers::Users::Create.handle(params)
        when '/login'
          status, headers, body = Web::Handlers::Users::Login.handle(params)
        when '/lists'
          status, headers, body = Web::Handlers::Lists::Create.handle(params, token)
        else
          status, headers, body = [404, {}, 'Not found']
        end
      end

      [status, headers, [body]]
    end
  end
end
