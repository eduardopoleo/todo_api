module AuthenticationHandler
  def self.included(child_class)
    child_class.before_action :authenticate!
  end

  def authenticate!
    halt 401, 'Unauthorized request' unless current_user
  end

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end
end