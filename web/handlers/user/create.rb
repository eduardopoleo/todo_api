# You need to use nested module so that ruby does not try to find it.
module Web
  module Handlers
    module Users
      class Create
        def self.handle(params)
          new(params).handle
        end

        def initialize(params)
          @params = params
        end

        def handle
          user = User.create(user_params)

          [201, { 'Content-Type' => 'aplication/json' }, user.to_hash.to_json]
        end

        private

        attr_reader :params


        def user_params
          {
            name: params['name'],
            email: params['email'],
            password: params['password']
          }
        end
      end
    end
  end
end


