# frozen_string_literal: true
require 'web_helper'

describe Web::Controllers::Users::Create do
  describe '.handle' do
    subject { described_class.handle(params) }

    context 'with correct params' do
      let(:params) do
        {
          email: 'ines_gomes@gomesgomes.com',
          name: 'Ines Agua Clara',
          password: 'bestpassword'
        }
      end

      it 'creates an user' do
        expect {
          subject
        }.to change(User, :count).by(1)
      end

      it 'creates a session' do
        expect {
          subject
        }.to change(Session, :count).by(1)
      end

      let(:response) do
        [
          201,
          { 'Content-Type' => 'aplication/json' },
          user.to_hash.merge(session_token: token).to_json
        ]
      end

      let(:token) { 'some_token' }

      let(:user) { create(:user) }

      it 'returns a 201' do
        allow(User).to receive(:create) { user }
        allow(SecureRandom).to receive(:base64) { token }

        expect(subject).to eq(response)
      end
    end

    context 'when theres an invitation associated to it' do
      let(:params) do
        {
          email: 'ines_gomes@gomesgomes.com',
          name: 'Ines Agua Clara',
          password: 'bestpassword',
          invitation_token: token
        }
      end
      
      let(:token) { 'lSqSXIm8rqVrqmy8WwJrKg==' }

      context 'when the invitation can be found' do
        let!(:invitation) { create(:invitation, token: token) }

        it 'sets the invitation token to nil' do
          subject
          expect(Invitation.last.token).to eq(nil)
        end
      end

      context "when the invitation can't be found" do
        it 'does not create the contact' do
          expect {
            subject
          }.not_to change(User, :count)

          expect(subject[0]).to eq(404)
        end
      end

      context 'when the invitation is associated to a group' do
        let!(:group) { create(:group) }
        let!(:invitation) { create(:invitation, group: group, token: token) }

        it 'associates the new user to a group' do
          subject
          expect(User.last.groups).to include(group)
        end
      end
    end
  end
end