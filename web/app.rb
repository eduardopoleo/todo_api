module Web
  class App # consider if this could be named as a controller
    def call(env)
      req = Rack::Request.new(env)
      params = JSON.parse(req.body.read)
      token = env['HTTP_AUTHORIZATION']

      if req.post?
        case req.path
        when '/users'
          # This handlers should be renamed controllers
          # They should inherit from a top level controller.
          status, headers, body = Web::Handlers::Users::Create.handle(params)
        when '/login'
          status, headers, body = Web::Handlers::Users::Login.handle(params)
        when '/lists'
          status, headers, body = Web::Handlers::Lists::Create.handle(params, token)
        when '/invitations'
          status, headers, body = Web::Handlers::Invitations::Create.handle(params, token)
        else
          status, headers, body = [404, {}, 'Not found']
        end
      end

      [status, headers, [body]]
    end
  end
end
