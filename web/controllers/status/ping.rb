module StatusController
  class Ping < BaseController
    def handle
      @status = 200
      @body = 'Life is good'
    end
  end
end