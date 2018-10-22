# You need to use nested module so that ruby does not try to find it.
require 'securerandom'

module Web
  module Handlers
    module Lists
      class Create
        def self.handle(params, token)
          new(params, token).handle
        end

        def initialize(params, token)
          @params = params
          @token = token
        end

        def handle
          # TODO: this is wrong. We should be able to stop execution way before
          if user 
            list = List.create(list_params)

            # TODO: these serializers are becoming all to common at this point
            [201, { 'Content-Type' => 'aplication/json' }, list.to_hash.to_json]
          else
            [401, { 'Content-Type' => 'aplication/json' }, { error: "Unauthorized" }.to_json]
          end
        end

        private

        attr_reader :token, :params

        def list_params
          { name: params['name'], user: user }
        end

        def user
          session = Session.where(token: token).first
          return unless session

          User.where(id: session.user_id).first
        end
      end
    end
  end
end