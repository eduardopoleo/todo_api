# You need to use nested module so that ruby does not try to find it.
require 'securerandom'

module ListsController
  class Create < BaseController
    include AuthenticationHandler

    def handle
      list = List.create(list_params)

      @status = 201
      @body = { id: list.id, name: list.name, created_at: list.created_at }.to_json
    end

    private

    def list_params
      { name: params['name'], user: current_user }
    end
  end
end
