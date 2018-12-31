module StatusController
  class Ping < BaseController
    def handle
      @status = 200
      @body = { message: 'Life is good' }.to_json
    end
  end
end