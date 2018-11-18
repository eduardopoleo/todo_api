module HomeController
  class Show < BaseController
    def handle
      [200, {}, ['Hello from home']]
    end
  end
end