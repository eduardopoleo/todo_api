class BaseController
  def self.handle(params)
    new(params).handle
  end

  def initialize(params)
    @params = params
  end

  private

  attr_reader :params
end
