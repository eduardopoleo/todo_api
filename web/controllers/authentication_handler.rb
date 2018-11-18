module AuthenticationHandler
  def self.included(child_class)
    child_class.before_action :autheticate!
  end

  def authenticate!

  end
end