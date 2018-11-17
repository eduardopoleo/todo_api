module UsersControllers
  class Create < BaseController
    def handle
      user = nil

      invitation = nil

      if params[:invitation_token]
        invitation = Invitation.where(token: params[:invitation_token]).first

        if invitation
          invitation.update(token: nil)
        else
          return [404, { 'Content-Type' => 'aplication/json' }, { message: 'This invitation has expired' }]
        end
      end

      DB.transaction do
        user = User.create(user_params)
        Session.create(user_id: user.id, token: token)

        if invitation && group = invitation.group
          UserGroup.create(user_id: user.id, group_id: group.id)
        end
      end
      
      [201, { 'Content-Type' => 'aplication/json' }, user.to_hash.merge(session_token: token).to_json]
    end

    private

    attr_reader :params

    def user_params
      { name: params['name'], email: params['email'], password: params['password'] }
    end

    def token
      @token ||= SecureRandom.base64
    end
  end
end
