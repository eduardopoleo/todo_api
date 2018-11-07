module Web
  module Handlers
    module Invitations
      class Create
        def self.handle(params)
          new(params).handle
        end

        def initialize(params)
          @params = params
        end

        def handle
          Invitation.create(invitation_params)
        end

        private

        attr_reader :params

        def invitation_params
          { email: params[:email], group_id: params[:group_id] }
        end
      end
    end
  end
end