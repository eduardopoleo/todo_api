module Web
  class App
    def call(env)
      req = Rack::Request.new(env)

      route = AppRouter.match(env['REQUEST_METHOD'], req.path)

      if route
        AppRouter.execute(route[:controller], params(req))
      else
        [404, { 'Content-Type' => 'text/html' }, ['Not Found']]
      end
    end

    private

    def params(req)
      req.get? ? req.params : JSON.parse(req.body.read)
    end
  end
end
