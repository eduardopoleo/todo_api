module Web
  class Route
  	attr_reader :verb, :path

  	def initialize(verb:, path:)
  		@verb = verb
  		@path = path
  	end
  end
end