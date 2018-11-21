# frozen_string_literal: true
require 'web_helper'

describe InvitationsController::Create do
  include Rack::Test::Methods

  def app
    EntryPoint.new
  end

  before do
    user = create(:user, name: 'miguel', email: 'miguel@gmail.com')
    env "rack.session", { user_id: user.id }
  end

  describe '.handle' do
    it 'creates the invitation' do
      expect {
        post '/invitations', email: 'some@dude.com'
      }.to change(Invitation, :count).by(1)
    end

    context 'when group_id is provided' do
      let(:group) { create(:group) }

      it 'associates the invitation to the group' do
        post '/invitations', email: 'some@dude.com', group_id: group.id
        expect(Invitation.last.group).to eq(group)
      end
    end
  end
end