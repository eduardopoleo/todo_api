# You need to use nested module so that ruby does not try to find it.
require 'securerandom'

module ListsController
  class Create < BaseController
    include AuthenticationHandler

    def handle
      list = List.create(list_params)
      
      [201, { 'Content-Type' => 'aplication/json' }, list.to_hash.to_json]
    end

    private

    attr_reader :token, :params

    def list_params
      { name: params['name'], user: current_user }
    end
  end
end
