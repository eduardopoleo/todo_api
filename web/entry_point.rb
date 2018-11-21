class EntryPoint
  def call(env)
    req = Rack::Request.new(env)

    route = WebApp.router.match(env['REQUEST_METHOD'], req.path)

    if route
      WebApp.router.execute(route[:controller], req)
    else
      [404, { 'Content-Type' => 'text/html' }, ['Not Found']]
    end
  end
end
