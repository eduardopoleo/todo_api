require 'securerandom'

module UsersController
  class Login < BaseController
    def handle
      user = User.where(email: params['email']).first
  
      if user && authorized?(user)
        session = Session.create(user: user)

        Rack::Response.new(*success).tap do |response|
          response.set_cookie('token', { value: session.token })
        end.finish
      else
        Rack::Response.new(*failure).finish
      end
    end

    private

    def success
      [ 
        [success_message],
        201, 
        headers
      ]
    end

    def success_message
      { message: 'You have successfully logged in!' }.to_json
    end

    def headers
      { 'Content-Type' => 'aplication/json' } 
    end

    def failure
      [
        [ { error: "Unauthorized" }.to_json ],
        401, 
        headers
      ]
    end


    # Seems like this is something that can be abstracted out of regular controllers
    # cuz does not seem correct to let developer know about rack internals

    # def response(body:, status:, headers:)
    #   res = Rack::Response.new(body, status, headers)

    #   res = yield res if block_given?

    #   res.finish
    # end

    def authorized?(user)
      bcrypt_password = BCrypt::Password.new(user.password_digest)

      bcrypt_password == params['password']
    end
  end
end

