module UsersController
  class Login < BaseController
    def handle
      user = User.where(email: params['email']).first

      if user && authorized?(user)
        session[:user_id] = user.id

        @body = "You've successfully logged in"
        @status = 201
      else
        @body = 'There seems to be a problem with you password or email. Try again'
        @status = 401
      end
    end

    private

    def authorized?(user)
      bcrypt_password = BCrypt::Password.new(user.password_digest)

      bcrypt_password == params['password']
    end
  end
end

