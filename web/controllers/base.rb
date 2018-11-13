module Web
  module Controllers
    class Base
      def self.handle(params)
        new(params).handle
      end

      def initialize(params)
        @params = params
      end
    end
  end
end