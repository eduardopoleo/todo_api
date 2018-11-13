require 'securerandom'

module Web
  module Controllers
    module Users
      class Login
        def self.handle(params)
          new(params).handle
        end

        def initialize(params)
          @params = params
        end

        def handle
          user = User.where(email: params['email']).first

          if user && authorized?(user)
            # TODO: For now we are going to have only 1 session available
            # Do we need to have different type of sessions? and based on that keep them?
            DB.transaction do
              Session.where(valid: true).update(valid: false)
              Session.create(user_id: user.id, token: token)
            end
            # This is not correct. The session token has to be on the headers. Even the CLI 
            # should know how to handle it.
            [201, { 'Content-Type' => 'aplication/json' }, { session_token: token }.to_json]
          else
            [401, { 'Content-Type' => 'aplication/json' }, { error: "Unauthorized" }.to_json]
          end
        end

        private

        attr_reader :params

        def token
          @token ||= SecureRandom.base64
        end

        def authorized?(user)
          bcrypt_password = BCrypt::Password.new(user.password_digest)

          bcrypt_password == params['password']
        end
      end
    end
  end
end


