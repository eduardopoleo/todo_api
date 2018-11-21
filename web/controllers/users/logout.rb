module UsersController
  class Logout < BaseController
    def handle
      session[:user_id] = nil

      @body = "You've successfully logged out"
      @status = 200
    end
  end
end