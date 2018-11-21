module InvitationsController
  class Create < BaseController
  	include AuthenticationHandler

    def handle
      Invitation.create(invitation_params)
    end

    private

    def invitation_params
      { email: params['email'], group_id: params['group_id'] }
    end
  end
end
