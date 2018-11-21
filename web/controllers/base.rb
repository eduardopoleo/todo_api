class BaseController
  class HandlerNotDefined < StandardError; end

  def self.before_actions
    # we do not use class variables because changing @@ will change the value
    # on all controllers which we do not want. We want the before actions to
    # be local to the controller
    @before_actions ||= []
  end

  def self.before_action(callback)
    before_actions << callback
  end

  # because we are using class level instance variables they only exist 
  # on the scope of the current class. But we need to make sure that
  # the child class have them set
  def self.inherited(child_class)
    before_actions.each { |cb| child_class.before_actions << cb }
  end

  def initialize(req)
    @req = req
    @status = 200
    @headers = { 'Content-Type' => 'aplication/json' }
    @body = []

    @session = req.session

    @params = req.get? ? req.params : post_params
  end

  def execute
    catch :halt do
      self.class.before_actions.each { |cb| self.send(cb) }
      handle
    end

    Rack::Response.new(@body, @status, @headers).finish
  end

  def halt(status, message)
    @status = status
    @body = [message]

    throw :halt
  end

  def handle
    raise HandlerNotDefined, 'Do not know how to handle this request'
  end

  private

  attr_reader :params, :req, :session

  def post_params
    # This handle both json or form params as long as it's properly set.
    case req.media_type
    when 'application/json'
      JSON.parse(req.body.read)
    else
      req.POST
    end
  end
end 