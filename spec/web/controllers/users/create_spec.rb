# frozen_string_literal: true
require 'web_helper'

describe UsersController::Create do
  include Rack::Test::Methods

  def app
    EntryPoint.new
  end

  it 'creates and user' do
    expect {
      post '/users'
    }.to change(User, :count).by(1)
  end

  it 'sets the right properties' do
    post '/users', name: 'jose', email: 'jose@gmail.com'

    user = User.last
    expect(user.name).to eq('jose')
    expect(user.email).to eq('jose@gmail.com')
  end

  it 'sets the session equal to the sign up user id' do
    post '/users', name: 'jose', email: 'jose1@gmail.com'

    user = User.last
    session = last_request.session
    expect(session[:user_id]).to eq(user.id)
  end

  it 'returns a successful json response' do
    post '/users', name: 'jose', email: 'jose1@gmail.com'

    expect(last_response.body).to eq({ message: 'You have successfully signed up!' }.to_json)
  end

  context "when an invitation token is passed invitation" do
    context 'when the invitaion exist' do
      let!(:invitation) { create(:invitation, token: 'my_token') }

      it 'nullifies the invitation' do
        post '/users', name: 'jose', email: 'jose1@gmail.com', invitation_token: 'my_token'
        expect(Invitation.last.token).to be_nil
      end

      context 'when the invitation is associated to a group' do
        let(:group) { create(:group) }
        let!(:invitation) { create(:invitation, token: 'my_token', group_id: group.id) }

        it 'creates the user group' do
          post '/users', name: 'jose', email: 'jose1@gmail.com', invitation_token: 'my_token'

          user_group = UserGroup.last
          expect(user_group.user_id).to eq(User.last.id)
          expect(user_group.group_id).to eq(Group.last.id)
        end
      end
    end

    context 'when the invitation does not exist' do
      it 'returns 404 and adequate error message' do
        post '/users', name: 'jose', email: 'jose1@gmail.com', invitation_token: 'my_token'
        expect(last_response.body).to eq({ message: 'This invitation has expired' }.to_json)
        expect(last_response.status).to eq(404)
      end
    end
  end
end