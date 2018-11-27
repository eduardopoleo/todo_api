module UsersController
  class Create < BaseController
    def handle
      # clean up this crap.
      user = nil
      invitation = nil
      db_session = nil

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
        db_session = Session.create(user: user)

        if invitation && group = invitation.group
          UserGroup.create(user_id: user.id, group_id: group.id)
        end
      end
      
      session[:user_id] = user.id

      @body = { message: 'You have successfully signed up!' }.to_json
      @status = 201
    end

    private

    def user_params
      { name: params['name'], email: params['email'], password: params['password'] }
    end
  end
end
